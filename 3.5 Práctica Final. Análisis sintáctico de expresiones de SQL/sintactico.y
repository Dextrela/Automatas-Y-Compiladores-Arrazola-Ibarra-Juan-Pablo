%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;  /* <--- ESTA ES LA LÍNEA QUE FALTA O NO LEYÓ GCC */
int yylex();
void yyerror(char *s);
%}

%token SELECT FROM WHERE INSERT INTO VALUES UPDATE SET DELETE AND OR
%token CREATE TABLE DROP INNER JOIN ON TIPO_DATO EXIT
%token ID NUM CADENA
%token ASTERISCO COMA PUNTO_COMA PUNTO LPAREN RPAREN IGUAL OP_RELACIONAL SALTO

%left OR
%left AND

%%
/* Lee el archivo entero, linea por linea */
codigo:
    linea
    | codigo linea
    ;

linea:
    consulta PUNTO_COMA SALTO { printf("   -> CONSULTA  VALIDA\n\n"); }
    | consulta PUNTO_COMA     { printf("   ->  CONSULTA VALIDA\n\n"); } 
    | EXIT PUNTO_COMA SALTO { printf("   -> saliendo del archivo.\n"); YYACCEPT; }
    | SALTO 
    | error SALTO { yyerrok; printf("\n"); }
    ;

consulta:
    sent_select   { printf("--- SELECT  ---\n"); }
    | sent_insert { printf("--- INSERT  ---\n"); }
    | sent_update { printf("--- UPDATE  ---\n"); }
    | sent_delete { printf("--- DELETE  ---\n"); }
    | sent_create { printf("--- CREATE TABLE  ---\n"); }
    | sent_drop   { printf("--- DROP TABLE  ---\n"); }
    ;

sent_select:
    SELECT campos FROM ID
    | SELECT campos FROM ID WHERE condicion
    | SELECT campos FROM ID INNER JOIN ID ON ID PUNTO ID IGUAL ID PUNTO ID
    ;

campos: ASTERISCO | lista_ids ;
lista_ids: ID | lista_ids COMA ID ;

sent_insert:
    INSERT INTO ID VALUES LPAREN lista_valores RPAREN
    ;

lista_valores: valor | lista_valores COMA valor ;

sent_update:
    UPDATE ID SET asignaciones
    | UPDATE ID SET asignaciones WHERE condicion
    ;

asignaciones: ID IGUAL valor | asignaciones COMA ID IGUAL valor ;

sent_delete:
    DELETE FROM ID | DELETE FROM ID WHERE condicion
    ;

sent_create:
    CREATE TABLE ID LPAREN def_columnas RPAREN
    ;

def_columnas: ID TIPO_DATO | def_columnas COMA ID TIPO_DATO ;

sent_drop:
    DROP TABLE ID
    ;

valor: NUM | CADENA ;

condicion:
    expresion OP_RELACIONAL expresion
    | expresion IGUAL expresion
    | condicion AND condicion
    | condicion OR condicion
    ;

expresion: ID | NUM | CADENA ;

%%

void yyerror(char *s) {
    fprintf(stderr, ">>> ERROR SINTACTICO: La consulta SQL esta mal estructurada <<<\n");
}

/* ====================================================================
   NUEVO MAIN PARA LECTURA DE ARCHIVOS
   ==================================================================== */
int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Error: Falta el archivo de entrada.\n");
        printf("Uso correcto: compilador.exe <archivo.txt>\n");
        return 1;
    }

    FILE *archivo = fopen(argv[1], "r");
    if (!archivo) {
        fprintf(stderr, "No se pudo abrir el archivo: %s\n", argv[1]);
        return 1;
    }

    yyin = archivo;

    printf("=====================================================\n");
    printf("   ANALIZANDO SCRIPT SQL: %s \n", argv[1]);
    printf("=====================================================\n\n");
    
    /* 4. Ejecutar el analisis */
    yyparse(); 
    
    /* 5. Limpieza y cierre */
    fclose(archivo);
    printf("=====================================================\n");
    printf("               ANALISIS FINALIZADO                   \n");
    printf("=====================================================\n");
    
    return 0;
}