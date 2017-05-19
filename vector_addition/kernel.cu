#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#define TPB 128

__global__ 
void addKernel(int *d_c, int *d_a, int *d_b)
{
	const int i = blockIdx.x*blockDim.x + threadIdx.x;
    d_c[i] = d_a[i] + d_b[i];
	printf("%u plus %u is %u.\n", d_a[i], d_b[i], d_c[i]);
}

void addArray(int *c, int *a, int *b, int len)
{
	int *d_a = 0;
	int *d_b = 0;
	int *d_c = 0;

	cudaMalloc(&d_a, len * sizeof(int));
	cudaMalloc(&d_b, len * sizeof(int));
	cudaMalloc(&d_c, len * sizeof(int));

	cudaMemcpy(d_a, a, len * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, b, len * sizeof(int), cudaMemcpyHostToDevice);

	addKernel << <len / TPB, TPB >> > (d_c, d_a, d_b);
	cudaMemcpy(c, d_c, len * sizeof(int), cudaMemcpyDeviceToHost);

	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);

}

