#include<stdio.h>

#define NUM_BLOCKS 16
#define BLOCK_WIDTH 1

__global__ void hello(){
    printf("Hello World! I am thread in block %d\n", blockIdx.x);
}

int main(int argc, char** argv){

    //launch a kernel
    hello<<<NUM_BLOCKS, BLOCK_WIDTH>>>();

    //force to printf()s to flush()
    cudaDeviceSynchronize();
    printf("END!!!!!\n");

    return 0;
}