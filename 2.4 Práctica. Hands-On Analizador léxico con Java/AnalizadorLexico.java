import java.util.regex.*;
import java.util.*;
import java.io.*;
import java.nio.file.*;
import javax.swing.*;

public class JavaLexer {

    enum TokenType { KEYWORD, IDENTIFIER, WHITESPACE, UNKNOWN, OPERATOR,
        SEPARATOR, FLOAT_LIT, HEX_LIT, BINARYLIT, OCTALLIT, INTEGERLIT, STRING_LIT, CHARLIT, JAVADOC }

    record Token(TokenType type, String lexeme, int line) {
        public String toString() {
            return String.format("[L%-3d] %-14s -> \"%s\"", line, type, lexeme);
        }
    }

    public static class LexicalError extends RuntimeException {
        public LexicalError(char badChar, int lineNum, int colNum) {
            super(String.format(
                "Error lexico [linea %d, col %d]: caracter ilegal '%c' (U+%04X)",
                lineNum, colNum, badChar, (int) badChar
            ));
        }
    }

    static final String KW_PATTERN =
        "\\b(abstract|assert|boolean|break|byte|case|catch|char|" +
        "class|const|continue|default|do|double|else|enum|extends|" +
        "final|finally|float|for|if|implements|import|instanceof|" +
        "int|interface|long|new|package|private|protected|public|" +
        "return|short|static|super|switch|synchronized|this|throw|" +
        "throws|try|void|volatile|while|true|false|null)\\b";

    static final Pattern MASTER = Pattern.compile(
        "(?<JAVADOC>/\\*\\*[\\s\\S]*?\\*/)|" +
        "(?<BLOCKCOMMENT>/\\*[\\s\\S]*?\\*/)|" +
        "(?<LINECOMMENT>//[^\\n]*)|" +
        "(?<STRINGLIT>\"([^\"\\\\]|\\\\.)*\")|" +
        "(?<CHARLIT>'([^'\\\\]|\\\\.)')|" +
        "(?<FLOATLIT>[0-9][0-9_]*\\.[0-9][0-9_]*([eE][+-]?[0-9]+)?[fFdD]?)|" +
        "(?<HEXADECIMALLIT>0[xX][0-9a-fA-F][0-9a-fA-F_]*[lL]?)|" +
        "(?<BINARYLIT>0[bB][01][01_]*[lL]?)|" +
        "(?<OCTALLIT>0[0-7]+[lL]?)|" +
        "(?<INTEGERLIT>0|[1-9][0-9_]*[lL]?)|" +
        "(?<KEYWORD>" + KW_PATTERN + ")|" +
        "(?<IDENTIFIER>[a-zA-Z_$][a-zA-Z0-9_$]*)|" +
        "(?<OPERATOR>==|!=|<=|>=|&&|\\|\\||<<|>>>|>>|\\+\\+|--|\\+=|-=|\\*=|/=|[+\\-*/%<>=!&|^~?:])|" +
        "(?<SEPARATOR>[(){}\\[\\];,.])|" +
        "(?<WHITESPACE>[ \\t\\r\\n]+)",
        Pattern.MULTILINE
    );

    public static List<Token> tokenize(String source) {
        List<Token> tokens = new ArrayList<>();
        List<LexicalError> errors = new ArrayList<>();
        Matcher m = MASTER.matcher(source);
        int line = 1, pos = 0;

        while (m.find()) {
            if (m.start() > pos) {
                String illegal = source.substring(pos, m.start());
                int col = pos - source.lastIndexOf('\n', pos);
                System.err.printf("! Error lexico [L%d, C%d]: '%s' (U+%04X)%n",
                        line, col, illegal, (int) illegal.charAt(0));
                errors.add(new LexicalError(illegal.charAt(0), line, col));
            }
            if (m.group("WHITESPACE") != null) {
                line += m.group("WHITESPACE").chars().filter(ch -> ch == '\n').count();
            } else if (m.group("JAVADOC") != null) {
                tokens.add(new Token(TokenType.JAVADOC, m.group(), line));
            } else if (m.group("KEYWORD") != null) {
                tokens.add(new Token(TokenType.KEYWORD, m.group(), line));
            } else if (m.group("IDENTIFIER") != null) {
                tokens.add(new Token(TokenType.IDENTIFIER, m.group(), line));
            } else if (m.group("OPERATOR") != null) {
                tokens.add(new Token(TokenType.OPERATOR, m.group(), line));
            } else if (m.group("SEPARATOR") != null) {
                tokens.add(new Token(TokenType.SEPARATOR, m.group(), line));
            } else if (m.group("FLOATLIT") != null) {
                tokens.add(new Token(TokenType.FLOAT_LIT, m.group(), line));
            } else if (m.group("HEXADECIMALLIT") != null) {
                tokens.add(new Token(TokenType.HEX_LIT, m.group(), line));
            } else if (m.group("BINARYLIT") != null) {
                tokens.add(new Token(TokenType.BINARYLIT, m.group(), line));
            } else if (m.group("OCTALLIT") != null) {
                tokens.add(new Token(TokenType.OCTALLIT, m.group(), line));
            } else if (m.group("INTEGERLIT") != null) {
                tokens.add(new Token(TokenType.INTEGERLIT, m.group(), line));
            } else if (m.group("STRINGLIT") != null) {
                tokens.add(new Token(TokenType.STRING_LIT, m.group(), line));
            } else if (m.group("CHARLIT") != null) {
                tokens.add(new Token(TokenType.CHARLIT, m.group(), line));
            }
            pos = m.end();
        }
        return tokens;
    }

    public static void main(String[] args) throws Exception {

        JFileChooser abrir = new JFileChooser();
        abrir.setDialogTitle("Selecciona el archivo a analizar");

        if (abrir.showOpenDialog(null) != JFileChooser.APPROVE_OPTION) {
            JOptionPane.showMessageDialog(null, "No seleccionaste archivo.");
            return;
        }

        File archivoEntrada = abrir.getSelectedFile();
        String source = Files.readString(archivoEntrada.toPath());

        // ⭐ GUARDAR SIEMPRE EN LA CARPETA DEL PROGRAMA
        String carpetaPrograma = System.getProperty("user.dir");
        File archivoSalida = new File(carpetaPrograma + File.separator + "salida.txt");

        List<Token> tokens = tokenize(source);

        try (PrintStream salida = new PrintStream(new FileOutputStream(archivoSalida))) {
            salida.println(" Tokens de: " + archivoEntrada.getName() + " ");
            tokens.forEach(salida::println);
            salida.println("\nTotal tokens: " + tokens.size());
        }

        JOptionPane.showMessageDialog(null,
                "Analisis terminado.\nArchivo guardado en:\n" + archivoSalida.getAbsolutePath());

        tokens.forEach(System.out::println);
    }
}