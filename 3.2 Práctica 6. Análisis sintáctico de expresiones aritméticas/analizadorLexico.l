%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "analizadorSintactico.tab.h" 

void yyerror(char *s);
%}

DIGITO  [0-9]
LETRA   [a-zA-Z_]

%%

{DIGITO}+("."{DIGITO}+)     { return DECIMAL; }
{DIGITO}+                   { return ENTERO; }
{LETRA}({LETRA}|{DIGITO})* { return ID; }

"+"     { return SUMA; }
"-"     { return RESTA; }
"*"     { return MULT; }
"/"     { return DIV; }
"="     { return '='; } 

"=="    { return OPERADOR_RELACIONAL; }
"!="    { return OPERADOR_RELACIONAL; }
"<="    { return OPERADOR_RELACIONAL; }
">="    { return OPERADOR_RELACIONAL; }
"<"     { return OPERADOR_RELACIONAL; }
">"     { return OPERADOR_RELACIONAL; }

"("     { return PAREN_IZQ; }
")"     { return PAREN_DER; }

"\n"    { return '\n'; } 
[ \t]+  { /* Ignorar solo espacios y tabs */ }

.       { printf("Error lexico: %s no reconocido\n", yytext); }

%%