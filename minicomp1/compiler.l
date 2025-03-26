%{
    #include<stdio.h>
    #include<stdlib.h>

    #include "y.tab.h"

    void yyerror(char *);

%}
%%

"#include<stdio.h>"     {return HEADER;}
"int"                   {return INT;}
"main"                  {return MAIN;}
"("                     {return LB;}
")"                     {return RB;}
"{"                     {return LCB;}
"}"                     {return RCB;}
","                     {return COMMA;}
";"                     {return SC;}
[a-zA-Z_]+              {return VAR;}
[ \t\n]+                ;
%%

int yywrap(){
    return 1;
}
