%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>


void yyerror(char *s);
void UpdateSymbol(char *name, int value);
int getSymbolValue(char *name);
int yylex();

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
%type <name> STATEMENT

%%
PROGRAM: PROGRAM STATEMENT NL	   {printf("%d",getSymbolValue($2));}
       | PROGRAM STATEMENT {printf("%d",getSymbolValue($2));}
       |
       ;

STATEMENT: IDENTIFIER EQ NUMBER SC {$$=strcpy($$,$1); UpdateSymbol($1,$3); free($1);}
	 ;

%%

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


