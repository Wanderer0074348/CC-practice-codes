dot .
Hello Hello

%%

aa {printf("1\n");}
b?a+b? {printf("2\n");}
b?a*b? {printf("3\n");}
. {printf("4\n");}


%%

int yywrap(){
	return 1;
}

int main(){
	yylex();
	return 0;
}
