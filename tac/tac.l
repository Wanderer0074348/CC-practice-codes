%{
	#include"y.tab.h"

	void yyerror(char* c);
%}

%%
[a-z0-9]+ { yylval.result = strdup(yytext); return VAR;}
"="	{ return EQ;}
"+"	{ return PLUS;}
"-"	{ return MINUS;}
"*"	{ return MUL;}
"/"	{ return DIV;}
"("	{ return LB;}
")"	{ return RB;}
"\n"	{ return NL;}
[\t ]+ ;


%%

int yywrap(){
	return 1;
}
