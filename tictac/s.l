%{	
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	
	#include"y.tab.h"

	void yyerror(char* c);
%}

%%

[a-z]	{ yylval.result = strdup(yytext); return VAR;}
"="	{ return EQ;}
"["	{ return LB;}
"]" 	{ return RB;}
"+"	{ return ADD;}
"*"	{ return MUL;}
"\n"	{ return NL;}
[\t ]	;

%%

int yywrap(){
	return 1;
}

