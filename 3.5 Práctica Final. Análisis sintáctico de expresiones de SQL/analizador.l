%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h" 
%}

%%
[Ss][Ee][Ll][Ee][Cc][Tt]    { return SELECT; }
[Ff][Rr][Oo][Mm]            { return FROM; }
[Ww][Hh][Ee][Rr][Ee]        { return WHERE; }
[Ii][Nn][Ss][Ee][Rr][Tt]    { return INSERT; }
[Ii][Nn][Tt][Oo]            { return INTO; }
[Vv][Aa][Ll][Uu][Ee][Ss]    { return VALUES; }
[Uu][Pp][Dd][Aa][Tt][Ee]    { return UPDATE; }
[Ss][Ee][Tt]                { return SET; }
[Dd][Ee][Ll][Ee][Tt][Ee]    { return DELETE; }
[Cc][Rr][Ee][Aa][Tt][Ee]    { return CREATE; }
[Tt][Aa][Bb][Ll][Ee]        { return TABLE; }
[Dd][Rr][Oo][Pp]            { return DROP; }
[Ii][Nn][Nn][Ee][Rr]        { return INNER; }
[Jj][Oo][Ii][Nn]            { return JOIN; }
[Oo][Nn]                    { return ON; }
[Aa][Nn][Dd]                { return AND; }
[Oo][Rr]                    { return OR; }
[Ee][Xx][Ii][Tt]|[Qq][Uu][Ii][Tt] { return EXIT; }

[Ii][Nn][Tt]|[Vv][Aa][Rr][Cc][Hh][Aa][Rr]|[Dd][Aa][Tt][Ee] { return TIPO_DATO; }

"*"                         { return ASTERISCO; }
","                         { return COMA; }
";"                         { return PUNTO_COMA; }
"."                         { return PUNTO; }
"("                         { return LPAREN; }
")"                         { return RPAREN; }
"="                         { return IGUAL; }
"<"|">"|"<="|">="|"!="      { return OP_RELACIONAL; }

[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
[0-9]+([.][0-9]+)?          { return NUM; }
"'"[^']*"'"                 { return CADENA; }

[ \t\r]+                    ; /* Ignorar espacios y retornos de carro de Windows */
\n                          { return SALTO; }
.                           { printf("Error lexico: Caracter no reconocido '%s'\n", yytext); }
%%