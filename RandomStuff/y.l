%%
a*b printf("1");
(a|b)*b printf("2");
c* printf("3");
%%

int main(){
	yylex();
	return 0;
}

int yywrap(){
	return 1;
}
