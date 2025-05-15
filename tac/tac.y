%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	
	int yylex();
	void yyerror(char *c);

	int temp_var_count = 0;
	int pointer_count = 0;

	void genQuadruple(char* op, char* arg1, char* arg2, char* res);
	void genTriple(char* op, char* arg1, char* arg2);
%}

%union{
	char *result;
};

%token<result> VAR
%token EQ PLUS MINUS MUL DIV LB RB NL

%type<result> expr term factor

%left PLUS MINUS
%left MUL DIV

%%

pgm: pgm NL stmt
   | stmt
   ;

stmt: VAR EQ expr{
	    	printf("Three address codes:\n%s := %s\n", $1, $3);
		genQuadruple("=",$3,"-",$1); //only for assignment, i.e a=b;
		genTriple("=",$3,"-");
	}
	;

expr: expr PLUS term{
    		$$ = malloc(10);
		sprintf($$, "T%d", temp_var_count++);
		printf("%s := %s + %s\n", $$, $1, $3);
		genQuadruple("+", $1, $3, $$);
		genTriple("+", $1, $3);
	}
	|expr MINUS term{
		$$ = malloc(10);
		sprintf($$, "T%d", temp_var_count++);
		printf("%s := %s - %s\n", $$, $1, $3);
		genQuadruple("-", $1, $3, $$);
		genTriple("-", $1, $3);
	}
	| term{
		$$ = strdup($1);
	}
	;
term:	term MUL factor{
		$$ = malloc(10);
		sprintf($$, "T%d", temp_var_count++);
		printf("%s := %s * %s\n", $$, $1, $3);
		genQuadruple("*", $1, $3, $$);
		genTriple("*", $1, $3);
	}
	|term DIV factor{
		$$ = malloc(10);
		sprintf($$, "T%d", temp_var_count++);
		printf("%s := %s / %s\n", $$, $1, $3);
		genQuadruple("/", $1, $3, $$);
		genTriple("/", $1, $3);
	}
	| factor{
		$$ = strdup($1);
	}
	;
factor: LB expr RB{
      		$$ = strdup($2);
	}
	| VAR{
		$$ = strdup($1);
	}
	;

%%

void genQuadruple(char* op, char* arg1, char* arg2, char* res){
	printf("QUADRUPLE: \t%s\t%s\t%s\t%s\n", op, arg1, arg2, res);
}

void genTriple(char* op, char* arg1, char* arg2){
	printf("TRIPLE: \t%s\t%s\t%s\n", op, arg1, arg2);
}

int main(int argc, char** argv){
	yyparse();
	return 0;
}

void yyerror(char *s){
	printf("%s",s);
}



