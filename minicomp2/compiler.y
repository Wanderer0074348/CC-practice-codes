%{
#include<stdio.h>
#include<stdlib.h>
void yyerror(char *);
int yylex();
%}

%token HEADER MAIN LB RB LCB RCB COMMA VAR SC
%token EQ
%token ADD SUB MULT DIV 
%token INT FLOAT DOUBLE CHAR

%left ADD SUB
%left MULT DIV

%%
PROGRAM: PROGRAM HEADER INT MAIN LB RB LCB BODY RCB {printf("Valid C Code\n");}
       |
       ;

BODY: DECLARATIONS OPERATIONS 
    | DECLARATIONS
    |
    ;

DECLARATIONS: DECLARATIONS DECLARATION
	    | DECLARATION
	    ;

DECLARATION: INT VAR_NAMES SC
	   | DOUBLE VAR_NAMES SC
	   | FLOAT VAR_NAMES SC
	   | CHAR VAR_NAMES SC
	   ;

VAR_NAMES: VAR COMMA VAR_NAMES
	 | VAR
	 ;

OPERATIONS: OPERATIONS OPERATION
	  | OPERATION
	  ;

OPERATION: VAR EQ EXPN SC
	 ;

EXPN: EXPN ADD EXPN
    | EXPN SUB EXPN
    | EXPN MULT EXPN
    | EXPN DIV EXPN
    | LB EXPN RB
    | VAR
    ;
%%

void yyerror(char *s){
	printf("Error: %s", s);
}

int main(){
	yyparse();
	return 0;
}



