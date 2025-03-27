%{
#include<stdio.h>
#include<stdlib.h>

#include "y.tab.h"

void yyerror(char *s);
%}

%%
"#include<stdio.h>"     {return HEADER;}
"int"                   {return INT;}
"main"                  {return MAIN;}
[a-z][a-zA-Z0-9_]*      {return IDENTIFIER;}
[0-9]+                  {return NUMBER;}
"+"                     {return PLUS;}
"="                     {return EQ;}
"("                     {return LB;}
")"                     {return RB;}
"{"                     {return LCB;}
"}"                     {return RCB;}
[ \t\n]*                ;

%%

int yywrap(){
    return 1;
}

