%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>

	void yyerror(char* c);

	#include "y.tab.h"
%}

%%


"#include<stdio.h>"	{ return HEADER;}
"int"			{ yylval.data_type = 0; return INT;}
"char"			{ yylval.data_type = 1; return CHAR;}
"float"			{ yylval.data_type = 2; return FLOAT;}
"double"		{ return DOUBLE;}
"main"			{ return MAIN;}
"("			{ return LB;}
")"			{ return RB;}
"{"			{ return LCB;}
"}"			{ return RCB;}
";"			{ return SC;}
","			{ return COMMA;}
"="			{ return EQ;}
[\+\-\*\/]		{ return OP;}
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.var_name = strdup(yytext); return VAR;}
[ \t\n]			;
. 			yyerror("INVALID");

%%

int yywrap(){
	return 1;
}
