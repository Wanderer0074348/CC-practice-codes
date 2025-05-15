#include<stdio.h>
#include<stdlib.h>

float limitedSquare(x) float x;{
	return (x<=-10.0||x>=10.0)?100:x*x;
}

int main(int arg, char **args){
	printf("%f\n",limitedSquare(atof(args[1])));
	for (int i=0; i<arg; i++){
		printf("%s\n", args[i]);
	}
	return 0;
}

