%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>

	void yyerror(const char* c);
	int yylex();

	// lookup table
	struct symbol_table{
		char* var_name;
		int type;
	}var_list[20];

	int var_count = 0;
	int current_data_type = 0;
	int expn_type = -1;
	int temp;

	extern int lookup(char *c);
	extern int insert(char *c, int type);
%}

%union{
	int data_type;
	char* var_name;
}


%token HEADER MAIN LB RB LCB RCB SC COMMA EQ OP
%token<var_name> VAR
%token<data_type> INT CHAR FLOAT DOUBLE

%type<data_type> DATA_TYPE
%start prm

%left OP

%%
prm: HEADER MAIN_TYPE MAIN LB RB LCB BODY RCB	{printf("Succesfully parsed");}
   | 
   ;


BODY: DECLARATION_STATEMENTS PROGRAM_STATEMENTS
    ;

DECLARATION_STATEMENTS: DECLARATION_STATEMENT DECLARATION_STATEMENTS {printf("Succesfully parsed declaration statements");}
		      |	DECLARATION_STATEMENT
		      ;

PROGRAM_STATEMENTS: PROGRAM_STATEMENT PROGRAM_STATEMENTS {printf("Succesfully parsed program statements");}
		  | PROGRAM_STATEMENT
		  ;

DECLARATION_STATEMENT: DATA_TYPE VAR_LIST SC {}
		     ;

VAR_LIST: VAR {
		insert($1, current_data_type);
	}
	| VAR COMMA VAR_LIST {
		insert($1, current_data_type);
	}
	;

PROGRAM_STATEMENT: VAR EQ A_EXPN SC {
			expn_type = -1;		// resets the expression type
		}
		;
A_EXPN:	A_EXPN OP A_EXPN 
      | LB A_EXPN RB
      | VAR {
      		if ((temp = lookup($1)) != -1){
			if (expn_type == -1){
				expn_type = temp;
			}else if(expn_type != temp){
				printf("Type mismatch!");
				exit(0);
			}
		} else{
			printf("variable undeclared!");
			exit(0);
		}
	}
	;

MAIN_TYPE: INT
	 ;

DATA_TYPE: INT {$$ = $1; current_data_type = $1;}
	 | FLOAT {$$ = $1; current_data_type = $1;}
	 | CHAR {$$ = $1; current_data_type = $1;}
	 | DOUBLE
	 ;


%%


int lookup(char* c){
	for (int i = 0; i< var_count; i++){
		if (strcmp(var_list[i].var_name, c) == 0){
			return var_list[i].type;
		}
	}

	return -1;  //variable not found
}

int insert(char* c, int type){
	if (lookup(c) >= 0){
		printf("Already present in the table!");
		exit(0);
	}

	var_list[var_count].var_name = strdup(c);
	var_list[var_count].type = type;
	printf("%s: %d\n", var_list[var_count].var_name, var_list[var_count].type);
	var_count++;
}


int main(int argc, char** argv){
	yyparse();
	return 0;
}

void yyerror(const char *c){
	printf("%s", c);
}

