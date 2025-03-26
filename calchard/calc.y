%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>

void yyerror(char *s);
void UpdateSymbol(char *name, int value);
int getSymbolValue(char *name);
int yylex();
int fact(int x);

typedef struct {
	char* name;
	int value;
} Variable;

Variable SymbolTable[100];
int SymbolCount = 0;

%}

%union {
	char* name;
	int value;
}

%token <name> IDENTIFIER
%token <value> NUMBER
%token EQ SC NL
%token ADD SUB MULT DIV POW FAC 
%token LB RB

%left ADD SUB FAC
%left MULT DIV
%right POW

%type <value> STATEMENT EXPRESSION

%%
PROGRAM: PROGRAM STATEMENT NL
       | PROGRAM STATEMENT
       |
       ;

STATEMENT: IDENTIFIER EQ EXPRESSION SC {UpdateSymbol($1,$3); free($1);}
	 ;

EXPRESSION: EXPRESSION ADD EXPRESSION {$$ = $1+$3;}
	  | EXPRESSION SUB EXPRESSION {$$ = $1-$3;}
	  | EXPRESSION MULT EXPRESSION {$$ = $1*$3;}
	  | EXPRESSION DIV EXPRESSION {$$ = $1/$3;}
	  | EXPRESSION POW EXPRESSION {$$ = pow($1,$3);}
	  | EXPRESSION FAC {$$ = fact($1);}
	  | LB EXPRESSION RB {$$ = $2;}
	  | NUMBER
	  ;
%%

int fact(int x){
	int ans;
	for (int i = x; i>1; i--){
		ans = ans*i;
	}
	return ans;
}


void UpdateSymbol(char *name, int value){
	for (int i=0; i<SymbolCount; i++){
		if (strcmp(SymbolTable[i].name, name)==0){
			SymbolTable[i].value = value;
			return;
		}
	}

	SymbolTable[SymbolCount].name = name;
	SymbolTable[SymbolCount].value = value;
	SymbolCount++;
}

int getSymbolValue(char *name){
	for (int i=0; i<SymbolCount; i++){
		if (strcmp(SymbolTable[i].name, name)==0){
			return SymbolTable[i].value;
		}
	}
}

void yyerror(char *s){
	printf("%s",s);
}

int main(){
	yyparse();
	return 0;
}


