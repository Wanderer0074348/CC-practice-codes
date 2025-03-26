%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include"y.tab.h"

void yyerror(char *s);
int yywrap();
%}

%%

[a-zA-Z_][a-zA-Z0-9_]*		{ yylval.name = strdup(yytext); return IDENTIFIER; }
[0-9]+				{ yylval.value = atoi(yytext); return NUMBER;}
"+"				{ return ADD;}
"-"				{ return SUB;}
"*"				{ return MULT;}
"/"				{ return DIV;}
"^"				{ return POW;}
"!"				{ return FAC;}
"("				{ return LB; }
")"				{ return RB; }	
"=" 				{ return EQ; }
";"				{ return SC; }
"\n"				{ return NL; }
[ \t]+			;
. 				{ printf("Lol"); exit(1);}

%%

int yywrap(){
	return 1;
}
