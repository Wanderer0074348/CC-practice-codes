%{
#include<stdio.h>
#include<stdlib.h>
#include"y.tab.h"
%}

%%

"int"		{ return INT;}
"float"		{ return FLOAT;}
"double"	{ return DOUBLE;}
"char"		{ return CHAR;}

"if"		{ printf("Nope lol"); exit(1);}
"else"		{ printf("Nope lol"); exit(1);}
"while"		{ printf("Nope lol"); exit(1);}
"for"		{ printf("Nope lol"); exit(1);}

"#include <stdio.h>"       { return HEADER; }
"main"                     { return MAIN; }
"("                        { return LB; }
")"                        { return RB; }
"{"                        { return LCB; }
"}"                        { return RCB; }
","                        { return COMMA; }
";"                        { return SC; }
"="                        { return EQ; }
"+"                        { return ADD; }
"-"                        { return SUB; }
"*"                        { return MULT; }
"/"                        { return DIV; }
[A-Za-z][A-Za-z0-9_]*      { return VAR; }
[ \n\t]*		   

%%

int yywrap(){
	return 1;
}
