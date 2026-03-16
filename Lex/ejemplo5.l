%option noyywrap
%{
 #include <stdio.h>
 #define palabra 1
%}
DIGITO [0-9]
MAYUSCULA [A-Z]
MINUSCULA [a-z]
%%

({MAYUSCULA}|{MINUSCULA}+){DIGITO}* {return palabra; }
%%

int main()
{
 yyin = fopen("archivoEntrada.txt", "r");
 yyout = fopen("archivoSalida.txt", "w");
 int token;
 while(yylex()) {
  token = yylex();
  if (token == palabra) { 
   fprintf(yyout, "RECONOCIDO\n");
  } else {
   fprintf(yyout, "NO RECONOCIDO\n");
  }
 }
 
  // if (token == 0) break;
 fclose(yyin);
 fclose(yyout);
 return 0;
}