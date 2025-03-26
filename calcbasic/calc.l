%{
#include<stdio.h>
#include<stdlib.h>

#include "y.tab.h"

void yyerror(char *);
%}

%%

[0-9]+		{ yylval = atoi(yytext); return INT ;}
"+"		{ return ADD;}
"-"		{ return SUB;}
"*"		{ return MUL;}
"/"		{ return DIV;}
"("		{ return LB;}
")"		{ return RB;}
[\n]		{ return NL;}
[ \t\s]		;

%%
int yywrap(){
	return 1;
}
