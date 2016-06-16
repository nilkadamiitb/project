#include<stdio.h>
//#include<cuda.h>
#include<cuda_runtime.h>



#define N 4
#define BLOCK_DIM 4
__global__ void matrixAdd (int *dev_a);
int main() {
int a[N*N]={};
int i;
for(i=0;i<16;i++)
{
  printf("enter the number");
  scanf("%d",&a[i]);
}
int *dev_a;
//int dev_b;
int size = N * N * sizeof(int);
// initialize a and b with real values (NOT SHOWN)
cudaMalloc((void**)&dev_a, size);
//cudaMalloc((void**)&dev_b, size);
//cudaMalloc((void**)&dev_c, size);
cudaMemcpy(dev_a, a, size, cudaMemcpyHostToDevice);
//cudaMemcpy(dev_b, b, size, cudaMemcpyHostToDevice);
dim3 dimBlock(BLOCK_DIM, BLOCK_DIM);
dim3 dimGrid((int)ceil(N/dimBlock.x),(int)ceil(N/dimBlock.y));
matrixAdd<<<dimGrid,dimBlock>>>(dev_a);
cudaMemcpy(a, dev_a, size, cudaMemcpyDeviceToHost);
cudaFree(dev_a); 
//cudaFree(dev_b); 

}
__global__ void matrixAdd (int *dev_a) {
int col = blockIdx.x * blockDim.x + threadIdx.x;
int row = blockIdx.y * blockDim.y + threadIdx.y;
int index = col + row * N;
//dev_b=index;
//}

if (col < N && row < N) {
//c[index] = a[index] + b[index];
printf("%d",dev_a[index]);

}
}
