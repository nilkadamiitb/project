


#include<stdio.h>
//#include<cuda.h>
#include<cuda_runtime.h>


#define N 32
#define T 32 // max threads per block
#include <stdio.h>
__global__ void vecAdd (int *a, int *b, int *c);
int main() {
int a[N], b[N], c[N];
int *dev_a, *dev_b, *dev_c;
// initialize a and b with real values (NOT SHOWN)
int size = N * sizeof(int);
cudaMalloc((void**)&dev_a, size);
cudaMalloc((void**)&dev_b, size);
cudaMalloc((void**)&dev_c, size);
cudaMemcpy(dev_a, a, size,cudaMemcpyHostToDevice);
cudaMemcpy(dev_b, b, size,cudaMemcpyHostToDevice);
vecAdd<<<(int)ceil(N/T),T>>>(dev_a,dev_b,dev_c);
cudaMemcpy(c, dev_c, size,cudaMemcpyDeviceToHost);
cudaFree(dev_a);
cudaFree(dev_b);
cudaFree(dev_c);
exit (0);
}
__global__ void vecAdd (int *a, int *b, int *c) {
int i = blockIdx.x * blockDim.x + threadIdx.x;
if (i < N) {
c[i] = a[i] + b[i];
printf("%d",c[i]);
}
}
