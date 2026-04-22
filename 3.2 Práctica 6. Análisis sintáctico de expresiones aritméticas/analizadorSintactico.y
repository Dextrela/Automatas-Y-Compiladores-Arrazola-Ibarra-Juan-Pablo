%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
int yylex();
void yyerror(char *s);
%}

%token DECIMAL ENTERO ID SUMA RESTA MULT DIV OPERADOR_RELACIONAL PAREN_IZQ PAREN_DER

%left SUMA RESTA
%left MULT DIV

%%

input:
    | input linea
    ;

linea:
    expresion '\n'          { printf("Aritmetica OK\n"); }
    | condicion '\n'        { printf("Condicion OK\n"); }
    | ID '=' expresion '\n' { printf("Asignacion OK\n"); } 
    | '\n'                  { /* Ignorar líneas vacías */ }
    | error '\n'            { yyerrok; } 
    ;

expresion:
    expresion SUMA expresion
    | expresion RESTA expresion
    | expresion MULT expresion
    | expresion DIV expresion
    | factor
    ;

factor:
    ENTERO
    | DECIMAL
    | ID
    | PAREN_IZQ expresion PAREN_DER
    ;

condicion:
    expresion OPERADOR_RELACIONAL expresion
    ;
%%

void yyerror(char *s) {
    fprintf(stderr, "Error sintactico detectado\n");
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *archivo = fopen(argv[1], "r");
        if (!archivo) {
            fprintf(stderr, "No se pudo abrir el archivo %s\n", argv[1]);
            return 1;
        }
        yyin = archivo;
    }
    printf("--- Iniciando Analisis del Archivo ---\n");
    yyparse();
    printf("--- Analisis Finalizado ---\n");
    return 0;
}