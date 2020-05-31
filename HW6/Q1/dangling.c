#include <stdlib.h>

void main(){
	int* pnt;
	makeDangling(&pnt);
	return 0;
}

void makeDangling(int** p){
	int x;
	*p=&x;
}