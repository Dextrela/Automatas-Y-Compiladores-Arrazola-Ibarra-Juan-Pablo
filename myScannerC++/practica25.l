%option noyywrap
%{
    /* Analizador Lexico para C++
       Desarrollado por: Arrazola Ibarra Juan Pablo */
    
    #include <stdio.h>
    int num_comentarios = 0;
%}

DIGITO   [0-9]
LETRA  [a-zA-Z]
ID   {LETRA}({LETRA}|{DIGITO})*

HEX    0[xX][0-9a-fA-F]+
BIN    0[bB][01]+
OCT    0[0-7]+
ENTERO 0|[1-9]{DIGITO}*
FLOAT  {DIGITO}+"."{DIGITO}*([eE][+-]?{DIGITO}+)?[fFdD]?

STRING  \"([^\"\\\\]|\\\\.)*\"
CHAR   \'([^\'\\\\]|\\\\.)\'

%%

"//".* { num_comentarios++; }
"/*"([^*]|\*+[^*/])*(\*+"/")  { num_comentarios++; }

"auto"|"bool"|"break"|"case"|"catch"|"char"|"class"|"const"|"continue"|"default"|"delete"|"do"|"double"|"else"|"enum"|"extern"|"false"|"float"|"for"|"friend"|"goto"|"if"|"inline"|"int"|"long"|"namespace"|"new"|"nullptr"|"operator"|"private"|"protected"|"public"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"template"|"this"|"throw"|"true"|"try"|"typedef"|"typename"|"union"|"unsigned"|"using"|"virtual"|"void"|"volatile"|"while"|"include"|"define"|"main"|"cout"|"cin"|"endl"|"std" {
    fprintf(yyout, "PALABRA RESERVADA: %s\n", yytext);
}

{HEX} { fprintf(yyout, "HEXADECIMAL: %s\n", yytext); } 
{BIN} { fprintf(yyout, "BINARIO: %s\n", yytext); }
{OCT} { fprintf(yyout, "OCTAL: %s\n", yytext); }
{FLOAT} { fprintf(yyout, "FLOAT: %s\n", yytext); }
{ENTERO} { fprintf(yyout, "ENTERO: %s\n", yytext); }
{STRING} { fprintf(yyout, "CADENA: %s\n", yytext); }
{CHAR} { fprintf(yyout, "CARACTER: %s\n", yytext); }

{ID} { fprintf(yyout, "IDENTIFICADOR: %s\n", yytext); }

"<=>"|"<<="|">>="|"=="|"!="|"<="|">="|"&&"|"||"|">>"|"<<"|"++"|"--"|"+="|"-="|"*="|"/="|"%="|"&="|"|="|"^="|"->"|"::"|"..."|"+"|"-"|"*"|"/"|"%"|"!"|"<"|">"|"="|"&"|"|"|"^"|"~"|"?"|":" { 
    fprintf(yyout, "OPERADOR: %s\n", yytext); 
}

"("|")"|"{"|"}"|"["|"]"|";"|","|"."|"#" { fprintf(yyout, "SEPARADOR: %s\n", yytext); }

[ \t\r\n]+ { /* Ignorar espacios */ }
.        { fprintf(yyout, "ERROR: %s\n", yytext); }

%%

int main() {
    printf("\n=== ANALIZADOR LEXICO C++ ===\n");
    printf("Desarrollado por: Arrazola Ibarra Juan Pablo\n");
    printf("================================\n\n");
    
    yyin = fopen("codigo.cpp", "r");
    if (!yyin) {
        printf("Error: No se encontro 'codigo.cpp'\n");
        return 1;
    }

    yyout = fopen("MyScanner.txt", "w");
    if (!yyout) {
        printf("Error: No se pudo crear 'MyScanner.txt'\n");
        fclose(yyin);
        return 1;
    }

    fprintf(yyout, "=== ANALISIS LEXICO ===\n");
    fprintf(yyout, "Desarrollado por: Arrazola Ibarra Juan Pablo\n");
    fprintf(yyout, "========================\n\n");
    
    yylex();

    fprintf(yyout, "\n--- RESUMEN ---\n");
    fprintf(yyout, "Total de comentarios: %d\n", num_comentarios);

    fclose(yyin);
    fclose(yyout);
    
    printf("Proceso finalizado\n");
    printf("Resultados guardados en MyScanner.txt\n");
    return 0;
}