%option noyywrap
%{
#include <stdio.h>
#include <TOKENS.h>
%}

%%

INICIO   { return TOKEN_INICIO; }
FIN      { return TOKEN_FIN; }
VECTOR   { return TOKEN_VECTOR; }
ENTERO   { return TOKEN_ENTERO; }
LOGICO   { return TOKEN_LOGICO; }

%%

int main() {
    int token;

    while(1) {
        token = yylex();

        if (token == TOKEN_INICIO)
            printf("token INICIO reconocido\n");

        if (token == TOKEN_FIN)
            printf("token FIN reconocido\n");

        if (token == TOKEN_VECTOR)
            printf("token VECTOR reconocido\n");

        if (token == TOKEN_ENTERO)
            printf("token ENTERO reconocido\n");

        if (token == TOKEN_LOGICO)
            printf("token LOGICO reconocido\n");

        if (token == 0)
            break;
    }

    return 0;
}