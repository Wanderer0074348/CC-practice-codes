%{
#include<stdio.h>
#include<stdlib.h>

void yyerror(char *);
int yylex();
%}

%token INT ADD SUB MUL DIV LB RB NL

%left ADD SUB
%left MUL DIV

%%

PGM: EXPR NL {printf("%d\n", $1);}
   |
   ;
EXPR: EXPR ADD EXPR	{$$=$1+$3;}
    | EXPR SUB EXPR	{$$=$1-$3;}
    | EXPR MUL EXPR	{$$=$1*$3;}
    | EXPR DIV EXPR	{$$=$1/$3;}
    | LB EXPR RB	{$$=$2;}
    | INT
    ;
%%

void yyerror(char *s){
	printf("%s", s);
}

int main(){
	yyparse();
	return 0;
}

