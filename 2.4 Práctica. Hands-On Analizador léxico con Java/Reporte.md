
---

# Reporte de Práctica: Analizador Léxico para Java
* Arrazola Ibarra Juan Pablo
* Autómatas y Compiladores
* Dr. Eduardo Cornejo Velazquez


# Análisis Léxico en Java — Patrones, Lexemas y Tokens

**Curso:** Autómatas y Compiladores — Unidad 2  
**Tema central:** Construcción de un analizador léxico para código Java mediante expresiones regulares.


---

## Materiales Necesarios

- JDK 17 o superior (OpenJDK u Oracle).
    
- Entorno de desarrollo integrado (IDE) como IntelliJ IDEA Community o Visual Studio Code con Java Extension Pack.
    
- Archivo de prueba `Ejemplo1.java``Ejemplo2.java``Ejemplo3.java`.
    
- Papel y lápiz para el diseño de diagramas de autómatas finitos.
    

---

## Marco Teórico

### Conceptos Fundamentales

|Concepto|Definición|Ejemplo|
|---|---|---|
|**Token**|Par _(tipo, valor)_ que representa una unidad léxica con significado. Es la salida del analizador léxico hacia el analizador sintáctico.|⟨KEYWORD, "class"⟩|
|**Lexema**|Secuencia de caracteres del código fuente que coincide con el patrón de un token.|`"class"`, `"MiClase"`, `"123"`|
|**Patrón**|Regla definida mediante una **expresión regular** que describe las cadenas válidas para un token.|`[a-zA-Z_][a-zA-Z0-9_]*`|

---

## Categorías de Tokens en Java

|Categoría|Ejemplos de lexemas|
|---|---|
|KEYWORD|`class`, `if`, `while`, `return`, `int`, `void`, `new`, `public`, `static`|
|IDENTIFIER|`miVariable`, `_count`, `MiClase`, `$precio`|
|INTEGER_LIT|`42`, `0`, `1_000_000L`|
|FLOAT_LIT|`3.14`, `1.5f`, `2.5e-3d`|
|STRING_LIT|`"Hola\nMundo"`, `""`|
|CHAR_LIT|`'a'`, `'\n'`, `'\u0041'`|
|OPERATOR|`+`, `-`, `*`, `==`, `!=`, `&&`, `++`, `<=`|
|SEPARATOR|`(` `)` `{` `}` `[` `]` `;` `,`|
|LINE_COMMENT|`// comentario`|
|BLOCK_COMMENT|`/* comentario */`|

---

## Tabla de Patrones (Expresiones Regulares)

|Token|Expresión Regular|Descripción|
|---|---|---|
|KEYWORD|`\b(class\|if\|else\|while\|for\|return\|int\|double\|boolean\|void\|new\|public\|private\|static\|final\|...)\b`|Palabras reservadas|
|IDENTIFIER|`[a-zA-Z_$][a-zA-Z0-9_$]*`|Letra, `_` o `$` seguido de caracteres válidos|
|INTEGER_LIT|`0\|[1-9][0-9_]*[lL]?`|Literal entero decimal|
|FLOAT_LIT|`[0-9][0-9_]*\.[0-9][0-9_]*([eE][+-]?[0-9]+)?[fFdD]?`|Literal flotante|
|STRING_LIT|`"([^"\\]\|\\.)*"`|Cadena con secuencias de escape|
|CHAR_LIT|`'([^'\\]\|\\.)'`|Literal carácter|
|OPERATOR|`==\|!=\|<=\|>=\|&&\|<<\|>>\|++\|--\|[+\-*/%<>=!&\|^~]`|Operadores simples y compuestos|
|SEPARATOR|`[(){}\[\];,.]`|Delimitadores|
|LINE_COMMENT|`//[^\n]*`|Comentario de línea|
|BLOCK_COMMENT|`/\*[\s\S]*?\*/`|Comentario de bloque|
|WHITESPACE|`[ \t\r\n]+`|Espacios y saltos de línea|
# Explicación

En este proyecto el programa del analizador léxico no fue hecho completamente desde cero, ya que el profesor nos proporcionó un código base para poder entender cómo funciona esta parte del compilador. A partir de ese código, lo que hicimos fue analizarlo, probarlo y después hacerle algunas modificaciones sencillas para mejorar su uso.

Lo principal que se agregó fue una **interfaz gráfica básica**. Antes, el programa funcionaba solo desde la consola y era necesario escribir manualmente el nombre o la ruta del archivo que se quería analizar. Esto podía ser un poco incómodo o causar errores si la ruta se escribía mal. Por eso se decidió agregar una ventana utilizando la librería **Swing** de Java.

Con esta mejora, ahora cuando se ejecuta el programa se abre una ventana que permite **seleccionar el archivo directamente desde el explorador del sistema**. Esto hace que el uso del programa sea más fácil y más práctico. El funcionamiento interno del analizador no cambió, solamente se modificó la forma en la que el usuario interactúa con él.

También se configuró que el programa genere automáticamente un archivo llamado `salida.txt` en la misma carpeta donde se está ejecutando. En ese archivo se guardan todos los tokens que el analizador reconoce en el código fuente. De esta manera ya no es necesario indicar manualmente dónde guardar el resultado.
###### En general, los cambios realizados fueron pequeños, pero ayudan a que el programa sea más cómodo de usar y más parecido a una herramienta real. Además, trabajar sobre el código proporcionado por el profesor permitió comprender mejor cómo funciona el análisis léxico y cómo se pueden hacer mejoras sin afectar la lógica principal del programa.
---
# Resultados

Se leyeron 3 códigos de la plataforma `GeekS for Geeks` y estos fueron los resultados obtenidos: 

# Jagged Array in Java
```java
class prueba1 {

    public static void main(String[] args){

        // Declaring 2-D array with 2 rows

        int arr[][] = new int[2][];

  

        // Making the above array Jagged

        arr[0] = new int[3];

        arr[1] = new int[2];

  

        // Initializing array

        int count = 0;

        for (int i = 0; i < arr.length; i++)

            for (int j = 0; j < arr[i].length; j++)

                arr[i][j] = count++;

  

        for (int i = 0; i < arr.length; i++) {

            for (int j = 0; j < arr[i].length; j++)

                System.out.print(arr[i][j] + " ");

            System.out.println();

        }

    }

}
```
Salida resumida
```
 Tokens de: prueba1 
[L1  ] KEYWORD        -> "class"
[L1  ] IDENTIFIER     -> "prueba1"
[L1  ] SEPARATOR      -> "{"
[L2  ] KEYWORD        -> "public"
[L2  ] KEYWORD        -> "static"
[L2  ] KEYWORD        -> "void"
[L2  ] IDENTIFIER     -> "main"
[L2  ] SEPARATOR      -> "("
[L2  ] IDENTIFIER     -> "String"
[L2  ] SEPARATOR      -> "["
[L2  ] SEPARATOR      -> "]"
[L2  ] IDENTIFIER     -> "args"
[L2  ] SEPARATOR      -> ")"
[L2  ] SEPARATOR      -> "{"
[L5  ] KEYWORD        -> "int"
[L5  ] IDENTIFIER     -> "arr"
[L5  ] SEPARATOR      -> "["
[L5  ] SEPARATOR      -> "]"
[L5  ] SEPARATOR      -> "["
[L5  ] SEPARATOR      -> "]"
[L5  ] OPERATOR       -> "="
[L5  ] KEYWORD        -> "new"
[L5  ] KEYWORD        -> "int"
[L5  ] SEPARATOR      -> "["
[L5  ] INTEGERLIT     -> "2"
[L5  ] SEPARATOR      -> "]"
[L5  ] SEPARATOR      -> "["
[L5  ] SEPARATOR      -> "]"
[L5  ] SEPARATOR      -> ";"
[L8  ] IDENTIFIER     -> "arr"
[L8  ] SEPARATOR      -> "["
[L8  ] INTEGERLIT     -> "0"
[L8  ] SEPARATOR      -> "]"
[L8  ] OPERATOR       -> "="
[L8  ] KEYWORD        -> "new"
[L8  ] KEYWORD        -> "int"
[L8  ] SEPARATOR      -> "["
[L8  ] INTEGERLIT     -> "3"
[L8  ] SEPARATOR      -> "]"
[L8  ] SEPARATOR      -> ";"
[L9  ] IDENTIFIER     -> "arr"
[L9  ] SEPARATOR      -> "["
[L9  ] INTEGERLIT     -> "1"
[L9  ] SEPARATOR      -> "]"
[L9  ] OPERATOR       -> "="
[L9  ] KEYWORD        -> "new"
[L9  ] KEYWORD        -> "int"
[L9  ] SEPARATOR      -> "["
[L9  ] INTEGERLIT     -> "2"
[L9  ] SEPARATOR      -> "]"
[L9  ] SEPARATOR      -> ";"
[L12 ] KEYWORD        -> "int"
[L12 ] IDENTIFIER     -> "count"
[L12 ] OPERATOR       -> "="
[L12 ] INTEGERLIT     -> "0"
[L12 ] SEPARATOR      -> ";"
[L13 ] KEYWORD        -> "for"
[L13 ] SEPARATOR      -> "("
[L13 ] KEYWORD        -> "int"
[L13 ] IDENTIFIER     -> "i"
[L13 ] OPERATOR       -> "="
[L13 ] INTEGERLIT     -> "0"
[L13 ] SEPARATOR      -> ";"
[L13 ] IDENTIFIER     -> "i"
[L13 ] OPERATOR       -> "<"
[L13 ] IDENTIFIER     -> "arr"
[L13 ] SEPARATOR      -> "."
[L13 ] IDENTIFIER     -> "length"
[L13 ] SEPARATOR      -> ";"
[L13 ] IDENTIFIER     -> "i"
[L13 ] OPERATOR       -> "++"
[L13 ] SEPARATOR      -> ")"
[L14 ] KEYWORD        -> "for"
[L14 ] SEPARATOR      -> "("
[L14 ] KEYWORD        -> "int"
[L14 ] IDENTIFIER     -> "j"
[L14 ] OPERATOR       -> "="
[L14 ] INTEGERLIT     -> "0"
[L14 ] SEPARATOR      -> ";"
[L14 ] IDENTIFIER     -> "j"
[L14 ] OPERATOR       -> "<"
[L14 ] IDENTIFIER     -> "arr"
[L14 ] SEPARATOR      -> "["
[L14 ] IDENTIFIER     -> "i"
[L14 ] SEPARATOR      -> "]"
[L14 ] SEPARATOR      -> "."
[L14 ] IDENTIFIER     -> "length"
[L14 ] SEPARATOR      -> ";"
[L14 ] IDENTIFIER     -> "j"
[L14 ] OPERATOR       -> "++"
[L14 ] SEPARATOR      -> ")"
[L15 ] IDENTIFIER     -> "arr"
[L15 ] SEPARATOR      -> "["
[L15 ] IDENTIFIER     -> "i"
[L15 ] SEPARATOR      -> "]"
[L15 ] SEPARATOR      -> "["
[L15 ] IDENTIFIER     -> "j"
[L15 ] SEPARATOR      -> "]"
[L15 ] OPERATOR       -> "="
[L15 ] IDENTIFIER     -> "count"
[L15 ] OPERATOR       -> "++"
[L15 ] SEPARATOR      -> ";"
[L17 ] KEYWORD        -> "for"
[L17 ] SEPARATOR      -> "("
[L17 ] KEYWORD        -> "int"
[L17 ] IDENTIFIER     -> "i"
[L17 ] OPERATOR       -> "="
[L17 ] INTEGERLIT     -> "0"
[L17 ] SEPARATOR      -> ";"
[L17 ] IDENTIFIER     -> "i"
[L17 ] OPERATOR       -> "<"
[L17 ] IDENTIFIER     -> "arr"
[L17 ] SEPARATOR      -> "."
[L17 ] IDENTIFIER     -> "length"
[L17 ] SEPARATOR      -> ";"
[L17 ] IDENTIFIER     -> "i"
[L17 ] OPERATOR       -> "++"
[L17 ] SEPARATOR      -> ")"
[L17 ] SEPARATOR      -> "{"
[L18 ] KEYWORD        -> "for"
[L18 ] SEPARATOR      -> "("
[L18 ] KEYWORD        -> "int"
[L18 ] IDENTIFIER     -> "j"
[L18 ] OPERATOR       -> "="
[L18 ] INTEGERLIT     -> "0"
[L18 ] SEPARATOR      -> ";"
[L18 ] IDENTIFIER     -> "j"
[L18 ] OPERATOR       -> "<"
[L18 ] IDENTIFIER     -> "arr"
[L18 ] SEPARATOR      -> "["
[L18 ] IDENTIFIER     -> "i"
[L18 ] SEPARATOR      -> "]"
[L18 ] SEPARATOR      -> "."
[L18 ] IDENTIFIER     -> "length"
[L18 ] SEPARATOR      -> ";"
[L18 ] IDENTIFIER     -> "j"
[L18 ] OPERATOR       -> "++"
[L18 ] SEPARATOR      -> ")"
[L19 ] IDENTIFIER     -> "System"
[L19 ] SEPARATOR      -> "."
[L19 ] IDENTIFIER     -> "out"
[L19 ] SEPARATOR      -> "."
[L19 ] IDENTIFIER     -> "print"
[L19 ] SEPARATOR      -> "("
[L19 ] IDENTIFIER     -> "arr"
[L19 ] SEPARATOR      -> "["
[L19 ] IDENTIFIER     -> "i"
[L19 ] SEPARATOR      -> "]"
[L19 ] SEPARATOR      -> "["
[L19 ] IDENTIFIER     -> "j"
[L19 ] SEPARATOR      -> "]"
[L19 ] OPERATOR       -> "+"
[L19 ] STRING_LIT     -> "" ""
[L19 ] SEPARATOR      -> ")"
[L19 ] SEPARATOR      -> ";"
[L20 ] IDENTIFIER     -> "System"
[L20 ] SEPARATOR      -> "."
[L20 ] IDENTIFIER     -> "out"
[L20 ] SEPARATOR      -> "."
[L20 ] IDENTIFIER     -> "println"
[L20 ] SEPARATOR      -> "("
[L20 ] SEPARATOR      -> ")"
[L20 ] SEPARATOR      -> ";"
[L21 ] SEPARATOR      -> "}"
[L22 ] SEPARATOR      -> "}"
[L23 ] SEPARATOR      -> "}"

Total tokens: 166

```
  
Java Program to Find if a Given Year is a Leap Year
```java
import java.io.*;

  

public class prueba2 {

    // Method to check leap year

    public static void isLeapYear(int year)

    {

        // flag to take a non-leap year by default

        boolean is_leap_year = false;

  

        // If year is divisible by 4

        if (year % 4 == 0) {

            is_leap_year = true;

  

            // To identify whether it is a

            // century year or not

            if (year % 100 == 0) {

                // Checking if year is divisible by 400

                // therefore century leap year

                if (year % 400 == 0)

                    is_leap_year = true;

                else

                    is_leap_year = false;

            }

        }

  

        // We land here when corresponding if fails

        // If year is not divisible by 4

        else

  

            // Flag dealing-  Non leap-year

            is_leap_year = false;

  

        if (!is_leap_year)

            System.out.println(year + " : Non Leap-year");

        else

            System.out.println(year + " : Leap-year");

    }

  

    // Driver Code

    public static void main(String[] args)

    {

        // Calling our function by

        // passing century year not divisible by 400

        isLeapYear(2000);

  

        // Calling our function by

        // passing Non-century year

        isLeapYear(2002);

    }

}
```

Salida Resumida
```
 Tokens de: prueba2 
[L1  ] KEYWORD        -> "import"
[L1  ] IDENTIFIER     -> "java"
[L1  ] SEPARATOR      -> "."
[L1  ] IDENTIFIER     -> "io"
[L1  ] SEPARATOR      -> "."
[L1  ] OPERATOR       -> "*"
[L1  ] SEPARATOR      -> ";"
[L3  ] KEYWORD        -> "public"
[L3  ] KEYWORD        -> "class"
[L3  ] IDENTIFIER     -> "prueba2"
[L3  ] SEPARATOR      -> "{"
[L5  ] KEYWORD        -> "public"
[L5  ] KEYWORD        -> "static"
[L5  ] KEYWORD        -> "void"
[L5  ] IDENTIFIER     -> "isLeapYear"
[L5  ] SEPARATOR      -> "("
[L5  ] KEYWORD        -> "int"
[L5  ] IDENTIFIER     -> "year"
[L5  ] SEPARATOR      -> ")"
[L6  ] SEPARATOR      -> "{"
[L8  ] KEYWORD        -> "boolean"
[L8  ] IDENTIFIER     -> "is_leap_year"
[L8  ] OPERATOR       -> "="
[L8  ] KEYWORD        -> "false"
[L8  ] SEPARATOR      -> ";"
[L11 ] KEYWORD        -> "if"
[L11 ] SEPARATOR      -> "("
[L11 ] IDENTIFIER     -> "year"
[L11 ] OPERATOR       -> "%"
[L11 ] INTEGERLIT     -> "4"
[L11 ] OPERATOR       -> "=="
[L11 ] INTEGERLIT     -> "0"
[L11 ] SEPARATOR      -> ")"
[L11 ] SEPARATOR      -> "{"
[L12 ] IDENTIFIER     -> "is_leap_year"
[L12 ] OPERATOR       -> "="
[L12 ] KEYWORD        -> "true"
[L12 ] SEPARATOR      -> ";"
[L16 ] KEYWORD        -> "if"
[L16 ] SEPARATOR      -> "("
[L16 ] IDENTIFIER     -> "year"
[L16 ] OPERATOR       -> "%"
[L16 ] INTEGERLIT     -> "100"
[L16 ] OPERATOR       -> "=="
[L16 ] INTEGERLIT     -> "0"
[L16 ] SEPARATOR      -> ")"
[L16 ] SEPARATOR      -> "{"
[L19 ] KEYWORD        -> "if"
[L19 ] SEPARATOR      -> "("
[L19 ] IDENTIFIER     -> "year"
[L19 ] OPERATOR       -> "%"
[L19 ] INTEGERLIT     -> "400"
[L19 ] OPERATOR       -> "=="
[L19 ] INTEGERLIT     -> "0"
[L19 ] SEPARATOR      -> ")"
[L20 ] IDENTIFIER     -> "is_leap_year"
[L20 ] OPERATOR       -> "="
[L20 ] KEYWORD        -> "true"
[L20 ] SEPARATOR      -> ";"
[L21 ] KEYWORD        -> "else"
[L22 ] IDENTIFIER     -> "is_leap_year"
[L22 ] OPERATOR       -> "="
[L22 ] KEYWORD        -> "false"
[L22 ] SEPARATOR      -> ";"
[L23 ] SEPARATOR      -> "}"
[L24 ] SEPARATOR      -> "}"
[L28 ] KEYWORD        -> "else"
[L31 ] IDENTIFIER     -> "is_leap_year"
[L31 ] OPERATOR       -> "="
[L31 ] KEYWORD        -> "false"
[L31 ] SEPARATOR      -> ";"
[L33 ] KEYWORD        -> "if"
[L33 ] SEPARATOR      -> "("
[L33 ] OPERATOR       -> "!"
[L33 ] IDENTIFIER     -> "is_leap_year"
[L33 ] SEPARATOR      -> ")"
[L34 ] IDENTIFIER     -> "System"
[L34 ] SEPARATOR      -> "."
[L34 ] IDENTIFIER     -> "out"
[L34 ] SEPARATOR      -> "."
[L34 ] IDENTIFIER     -> "println"
[L34 ] SEPARATOR      -> "("
[L34 ] IDENTIFIER     -> "year"
[L34 ] OPERATOR       -> "+"
[L34 ] STRING_LIT     -> "" : Non Leap-year""
[L34 ] SEPARATOR      -> ")"
[L34 ] SEPARATOR      -> ";"
[L35 ] KEYWORD        -> "else"
[L36 ] IDENTIFIER     -> "System"
[L36 ] SEPARATOR      -> "."
[L36 ] IDENTIFIER     -> "out"
[L36 ] SEPARATOR      -> "."
[L36 ] IDENTIFIER     -> "println"
[L36 ] SEPARATOR      -> "("
[L36 ] IDENTIFIER     -> "year"
[L36 ] OPERATOR       -> "+"
[L36 ] STRING_LIT     -> "" : Leap-year""
[L36 ] SEPARATOR      -> ")"
[L36 ] SEPARATOR      -> ";"
[L37 ] SEPARATOR      -> "}"
[L40 ] KEYWORD        -> "public"
[L40 ] KEYWORD        -> "static"
[L40 ] KEYWORD        -> "void"
[L40 ] IDENTIFIER     -> "main"
[L40 ] SEPARATOR      -> "("
[L40 ] IDENTIFIER     -> "String"
[L40 ] SEPARATOR      -> "["
[L40 ] SEPARATOR      -> "]"
[L40 ] IDENTIFIER     -> "args"
[L40 ] SEPARATOR      -> ")"
[L41 ] SEPARATOR      -> "{"
[L44 ] IDENTIFIER     -> "isLeapYear"
[L44 ] SEPARATOR      -> "("
[L44 ] INTEGERLIT     -> "2000"
[L44 ] SEPARATOR      -> ")"
[L44 ] SEPARATOR      -> ";"
[L48 ] IDENTIFIER     -> "isLeapYear"
[L48 ] SEPARATOR      -> "("
[L48 ] INTEGERLIT     -> "2002"
[L48 ] SEPARATOR      -> ")"
[L48 ] SEPARATOR      -> ";"
[L49 ] SEPARATOR      -> "}"
[L50 ] SEPARATOR      -> "}"

Total tokens: 123

```


# Java Program to Find the Perimeter of a Rectangle
```java
class prueba3 {

    static int calculatePerimeter(int length, int breadth) {

        return 2 * (length + breadth);

    }

    public static void main(String[] args) {

  

        int length = 10;

        int breadth = 20;

  

        int perimeter = calculatePerimeter(length, breadth);

        System.out.println("The perimeter of the rectangle is: " + perimeter);

    }

}
```
Salida resumida
```
 Tokens de: prueba3.java 
[L1  ] KEYWORD        -> "class"
[L1  ] IDENTIFIER     -> "prueba3"
[L1  ] SEPARATOR      -> "{"
[L2  ] KEYWORD        -> "static"
[L2  ] KEYWORD        -> "int"
[L2  ] IDENTIFIER     -> "calculatePerimeter"
[L2  ] SEPARATOR      -> "("
[L2  ] KEYWORD        -> "int"
[L2  ] IDENTIFIER     -> "length"
[L2  ] SEPARATOR      -> ","
[L2  ] KEYWORD        -> "int"
[L2  ] IDENTIFIER     -> "breadth"
[L2  ] SEPARATOR      -> ")"
[L2  ] SEPARATOR      -> "{"
[L3  ] KEYWORD        -> "return"
[L3  ] INTEGERLIT     -> "2"
[L3  ] OPERATOR       -> "*"
[L3  ] SEPARATOR      -> "("
[L3  ] IDENTIFIER     -> "length"
[L3  ] OPERATOR       -> "+"
[L3  ] IDENTIFIER     -> "breadth"
[L3  ] SEPARATOR      -> ")"
[L3  ] SEPARATOR      -> ";"
[L4  ] SEPARATOR      -> "}"
[L5  ] KEYWORD        -> "public"
[L5  ] KEYWORD        -> "static"
[L5  ] KEYWORD        -> "void"
[L5  ] IDENTIFIER     -> "main"
[L5  ] SEPARATOR      -> "("
[L5  ] IDENTIFIER     -> "String"
[L5  ] SEPARATOR      -> "["
[L5  ] SEPARATOR      -> "]"
[L5  ] IDENTIFIER     -> "args"
[L5  ] SEPARATOR      -> ")"
[L5  ] SEPARATOR      -> "{"
[L7  ] KEYWORD        -> "int"
[L7  ] IDENTIFIER     -> "length"
[L7  ] OPERATOR       -> "="
[L7  ] INTEGERLIT     -> "10"
[L7  ] SEPARATOR      -> ";"
[L8  ] KEYWORD        -> "int"
[L8  ] IDENTIFIER     -> "breadth"
[L8  ] OPERATOR       -> "="
[L8  ] INTEGERLIT     -> "20"
[L8  ] SEPARATOR      -> ";"
[L10 ] KEYWORD        -> "int"
[L10 ] IDENTIFIER     -> "perimeter"
[L10 ] OPERATOR       -> "="
[L10 ] IDENTIFIER     -> "calculatePerimeter"
[L10 ] SEPARATOR      -> "("
[L10 ] IDENTIFIER     -> "length"
[L10 ] SEPARATOR      -> ","
[L10 ] IDENTIFIER     -> "breadth"
[L10 ] SEPARATOR      -> ")"
[L10 ] SEPARATOR      -> ";"
[L11 ] IDENTIFIER     -> "System"
[L11 ] SEPARATOR      -> "."
[L11 ] IDENTIFIER     -> "out"
[L11 ] SEPARATOR      -> "."
[L11 ] IDENTIFIER     -> "println"
[L11 ] SEPARATOR      -> "("
[L11 ] STRING_LIT     -> ""The perimeter of the rectangle is: ""
[L11 ] OPERATOR       -> "+"
[L11 ] IDENTIFIER     -> "perimeter"
[L11 ] SEPARATOR      -> ")"
[L11 ] SEPARATOR      -> ";"
[L12 ] SEPARATOR      -> "}"
[L13 ] SEPARATOR      -> "}"

Total tokens: 68

```

## Cuestionario

### 1. ¿Qué sucede si se eliminan los límites de palabra `\b` del patrón de palabras reservadas?

El metacarácter `\b` permite que la expresión regular identifique **palabras completas** dentro del código fuente.  
Si este elemento se elimina, el analizador podría detectar palabras reservadas como fragmentos dentro de identificadores más extensos.

Por ejemplo, en el identificador `interfaceStatus`, el lexer podría interpretar incorrectamente la secuencia `interface` como una palabra reservada, lo cual generaría una clasificación léxica errónea.

---

### 2. ¿Por qué el reconocimiento de palabras reservadas debe realizarse antes que el de identificadores?

Las palabras reservadas cumplen con la misma estructura léxica que los identificadores válidos.  
Ambos comienzan con letras o símbolos permitidos y pueden contener dígitos o guiones bajos.

Si el patrón de identificadores se evalúa primero, todas las palabras reservadas serían clasificadas como identificadores.  
Por esta razón, el analizador léxico debe verificar inicialmente si el lexema pertenece al conjunto de **keywords** del lenguaje.

---

### 3. ¿Es posible utilizar una sola expresión regular para reconocer identificadores y palabras reservadas?

Sí, es viable implementar una expresión regular general que detecte cualquier cadena válida como identificador.  
Posteriormente, el programa puede realizar una comprobación adicional para determinar si el lexema coincide con alguna palabra reservada.

Este enfoque implica una fase de **post–procesamiento**, en la cual el lexema reconocido se compara con una colección previamente definida de keywords.

---

### 4. ¿Cómo se maneja el operador ternario `?:` dentro del análisis léxico?

El analizador léxico reconoce los símbolos `?` y `:` como **tokens independientes**, ya que su función principal es segmentar el código en unidades léxicas.

La verificación de que ambos operadores formen una estructura ternaria válida corresponde al **analizador sintáctico**, el cual evalúa la correcta organización de los tokens dentro de la gramática del lenguaje.

---

### 5. ¿Por qué el operador `>>>` debe tener prioridad sobre `>>` en la expresión regular?

Esto se debe al principio conocido como **máxima coincidencia** (_maximal munch_), el cual establece que el analizador léxico debe consumir la secuencia de caracteres más larga posible.

Si el patrón `>>` se evaluara antes que `>>>`, el analizador reconocería únicamente los dos primeros símbolos, dejando el tercer carácter como un token independiente, lo cual provocaría una segmentación incorrecta.

---

### 6. ¿Cuál es la diferencia entre un operador y un separador desde el punto de vista gramatical?

Un **operador** representa una acción o transformación sobre uno o más operandos, como operaciones aritméticas, comparaciones o asignaciones.

En contraste, un **separador** tiene la función de organizar la estructura del programa, delimitando bloques, listas de parámetros o instrucciones.  
Los separadores no realizan cálculos, sino que definen la forma sintáctica del código.

---

### 7. ¿Por qué la secuencia `08` no es válida como número octal y cómo se ajusta la expresión regular?

En lenguajes derivados de C, incluyendo Java, un número que comienza con `0` se interpreta como octal.  
En este sistema numérico solo son válidos los dígitos del **0 al 7**.

Por ello, la presencia del dígito `8` invalida la notación.  
La expresión regular correcta debe restringir los caracteres permitidos a ese rango, evitando así coincidencias incorrectas.

---

### 8. ¿Cómo podría extenderse el patrón de cadenas para soportar bloques de texto (`Text Blocks`)?

Para reconocer bloques de texto delimitados por comillas triples (`"""`), es necesario definir un patrón que capture cualquier carácter, incluyendo saltos de línea, hasta encontrar el delimitador de cierre correspondiente.

Este patrón debe evaluarse antes del reconocimiento de cadenas tradicionales, con el fin de evitar coincidencias parciales.

---

### 9. ¿Debe el analizador léxico validar si un número se encuentra dentro del rango permitido por el tipo de dato?

No corresponde al análisis léxico realizar validaciones de tipo semántico.  
La función del lexer se limita a verificar que la secuencia de caracteres tenga una **forma válida**.

La comprobación de si el valor numérico excede los límites de un tipo de dato específico es responsabilidad del **análisis semántico**.

---

### 10. ¿Qué ocurre si un comentario de bloque no se cierra correctamente?

Si el patrón de comentario de bloque no encuentra el delimitador de cierre, el analizador léxico no podrá reconocer la coincidencia completa.

En consecuencia, el texto restante será tratado como una secuencia de caracteres inválidos o generará errores léxicos, dependiendo de la estrategia de recuperación implementada.

---

### 11. ¿Es conveniente distinguir los comentarios JavaDoc de otros comentarios de bloque?

Sí, ya que los comentarios JavaDoc poseen una finalidad específica relacionada con la generación automática de documentación.

Diferenciarlos como un tipo de token independiente permite que herramientas externas o entornos de desarrollo realicen un procesamiento especial sobre ellos.

---

### 12. ¿Cómo difiere la recuperación de errores entre el análisis léxico y el análisis sintáctico?

En el análisis léxico, la recuperación suele ser sencilla: el analizador omite el carácter no reconocido y continúa procesando el resto del archivo.

Por otro lado, el análisis sintáctico requiere estrategias más complejas, como la sincronización en puntos seguros de la gramática, para poder continuar la evaluación del programa sin detener completamente la compilación.

---