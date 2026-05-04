%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h" 

void yyerror(char *s);
%}

%%
"if"                { return IF; }
"for"               { return FOR; }
"while"             { return WHILE; }
"print"             { return PRINT; }
"in"                { return IN; }
":"                 { return DOS_PUNTOS; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }

[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
[0-9]+"."[0-9]+     { return NUM_FLOAT; }
[0-9]+              { return NUM_INT; }

"<"|">"|"=="|"!="|"<="|">="  { return OPERADOR_RELACIONAL; }
"="                 { return IGUAL; }
"+"                 { return MAS; }
"-"                 { return MENOS; }
"*"                 { return POR; }
"/"                 { return DIV; }

"\""[^\"]*"\""      { return CADENA; }

"#".* ;
"\"\"\""([^\"]|"\""[^\"]|"\"\""[^\"])*"\"\"\"" ;

[ \t]               ;
\n                  { return SALTO; }
.                   { printf("Error lexico: %s\n", yytext); }
%%