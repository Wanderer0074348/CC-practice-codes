%{
    #include<stdio.h>
    #include<stdlib.h>

    void yyerror(char *);
    int yylex();
%}

%token HEADER INT MAIN LB RB LCB RCB VAR COMMA SC 

%%
PGM: 
    HEADER INT MAIN LB RB LCB BODY RCB SC {printf("Valid Code");};

BODY:
    EXPRS;

EXPRS:
    EXPRS EXPR
    |   EXPR;

EXPR:
    INT VARS SC {printf("Valid definition");};

VARS:
    VAR COMMA VARS
    |   VAR

%%

void yyerror(char *s){
    printf("Error: %s", s);
}

int main(){
    yyparse();
    return 0;
}