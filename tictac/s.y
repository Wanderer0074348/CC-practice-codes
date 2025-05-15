%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    void yyerror(char* c);
    int yylex();

    int temp_var_counter = 0;
//    int pointer_counter = 0;
%}

%union{
    char* result;
}

%token<result> VAR
%token EQ LB RB ADD MUL NL

%type<result> pgm stmt expr factor term
%left ADD
%left MUL

%%
pgm: pgm NL stmt
   | stmt
   | /* empty */
   ;

stmt: VAR EQ expr {
        printf("%s := %s\n", $1, $3);
        printf("= %s . %s\n", $3, $1);
        printf("= %s .\n", $3);
    }
    ;

expr: expr ADD term {
        $$ = malloc(10);
        sprintf($$, "T%d", temp_var_counter++);
        printf("%s := %s + %s\n", $$, $1, $3);
    }
    | term {
        $$ = strdup($1);
    }
    ;

term: term MUL factor {
        $$ = malloc(10);
        sprintf($$, "T%d", temp_var_counter++);
        printf("%s := %s * %s\n", $$, $1, $3);
    }
    | factor {
        $$ = strdup($1);
    }
    ;

factor: VAR LB VAR RB {
        // Generate code for array access a[i]
        // First compute offset: i*4
        char* temp = malloc(10);
        sprintf(temp, "T%d", temp_var_counter++);
        printf("%s := %s * 4\n", temp, $3);
        
        // Then compute array access
        $$ = malloc(10);
        sprintf($$, "T%d", temp_var_counter++);
        printf("%s := %s[%s]\n", $$, $1, temp);
    }
    | VAR {
        $$ = strdup($1);
    }
    ;

%%

int main(){
    yyparse();
    return 0;
}

void yyerror(char* c){
    printf("Syntax error: %s\n", c);
}
    	

