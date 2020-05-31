#include <stdio.h>
#include <stdlib.h>

int changeFlag(int *f){
	*f = 0;
	return 0;
}
	
int someFunc(int a){
	return 0;
}


int main()
{
	int* flag;
	*flag = 1;
		
	someFunc(changeFlag(flag));
	
	printf("%d",*flag);
	return 0;
}

