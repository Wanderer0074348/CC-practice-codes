%{
#include<stdio.h>
#include<stdlib.h>

extern int yylex();
extern void yyrestart(FILE *);
void yyerror(char *s);
%}

%token HEADER INT MAIN LB RB LCB RCB
%token PLUS EQ
%token IDENTIFIER NUMBER

%%
PROGRAM:PROGRAM HEADER INT MAIN LB RB LCB BODY RCB {printf("Valid code\n");}
    |   
    ;

BODY:   EXPRS 
    |   
    ;

EXPRS:  EXPRS EXPRESSION
    | EXPRESSION
    ;

EXPRESSION: INT IDENTIFIER EQ NUMBER
    ;

%%

void yyerror(char *s){
    printf("%s", s);
}

int main(int argc, char** argv){
    // FILE *input = fopen(argv[1],"r");
    // yyrestart(input);
    yyparse();
    // fclose(input);
    return 1;
}