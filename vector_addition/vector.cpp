#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include "kernel.h"
#define N 10000

int main()
{
	int *a = (int*)calloc(N, sizeof(int));
	int *b = (int*)calloc(N, sizeof(int));
	int *c = (int*)calloc(N, sizeof(int));

	for (int i = 0; i < N; ++i)
	{
		a[i] = i;
		b[i] = N-i;
	}

	addArray(c, a, b, N);

	free(a);
	free(b);
	free(c);
	return 0;
}