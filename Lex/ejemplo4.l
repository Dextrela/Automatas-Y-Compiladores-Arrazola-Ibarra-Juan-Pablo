%option noyywrap
%{
#include <stdio.h>

#define TOKEN_ID 1
#define TOKEN_NUMERO 2

%}

%%

[A-Za-z][A-Za-z0-9]*    { printf("TOKEN_ID=%s\n", yytext); }

[0-9]+                  { printf("TOKEN_NUMERO=%s\n", yytext); }


%%

int main() {
    yylex();
    return 0;
}