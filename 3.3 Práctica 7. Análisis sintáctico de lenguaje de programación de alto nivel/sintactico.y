%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
int yylex();
void yyerror(char *s);
%}

%token IF FOR WHILE PRINT DOS_PUNTOS ID NUM_INT NUM_FLOAT OPERADOR_RELACIONAL IGUAL SALTO LPAREN RPAREN IN CADENA
%token MAS MENOS POR DIV

%left MAS MENOS
%left POR DIV

%%
codigo:
    linea
    | codigo linea
    ;

linea:
    estructura SALTO {
        if ($1 == 1) printf("ASIGNACION/DECLARACION COMPLEJA\n");
        else if ($1 == 2) printf("ESTRUCTURA IF \n");
        else if ($1 == 3) printf("ESTRUCTURA WHILE \n");
        else if ($1 == 4) printf("ESTRUCTURA FOR \n");
        else if ($1 == 5) printf("FUNCION PRINT\n");
    }
    | SALTO 
    | error SALTO { yyerrok; }
    ;

estructura:
    declaracion   { $$ = 1; }
    | sent_if     { $$ = 2; }
    | sent_while  { $$ = 3; }
    | sent_for    { $$ = 4; }
    | sent_print  { $$ = 5; }
    ;

sent_if:
    IF condicion DOS_PUNTOS estructura
    | IF condicion DOS_PUNTOS SALTO estructura
    ;

sent_while:
    WHILE condicion DOS_PUNTOS estructura
    | WHILE condicion DOS_PUNTOS SALTO estructura
    ;

sent_for:
    FOR ID IN ID DOS_PUNTOS estructura
    | FOR ID IN ID DOS_PUNTOS SALTO estructura
    ;

declaracion:
    ID IGUAL expresion
    ;

expresion:
    ID | NUM_INT | NUM_FLOAT | CADENA
    | expresion MAS expresion
    | expresion MENOS expresion
    | expresion POR expresion
    | expresion DIV expresion
    | LPAREN expresion RPAREN
    ;

sent_print:
    PRINT LPAREN contenido_print RPAREN
    ;

contenido_print:
    expresion | /* vacío */
    ;

condicion:
    expresion OPERADOR_RELACIONAL expresion
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, ">>> ERROR SINTACTICO: Estructura no valida <<<\n");
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *archivo = fopen(argv[1], "r");
        if (!archivo) {
            printf("Error al abrir el archivo.\n");
            return 1;
        }
        yyin = archivo;
    }
    printf("+++ Analizando Codigo Python +++\n");
    yyparse();
    printf("+++ Analisis Finalizado +++\n");
    return 0;
}