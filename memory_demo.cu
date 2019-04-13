#include<stdio.h>


//
// Todo - Write Kernels

//


int main(int argc, char **argv){

    use_local_memory_GPU<<<1, 128>>>(2.0f);


    // array on host 
    float h_arr[128];

    // pointer for global memory on GPU
    float *d_arr;

    //allocate global memory on GPU device as store results in d_arr
    cudaMalloc((void **)&d_arr, sizeof(float) * 128);

    //copy data from host memory to device memory
    cudaMemcpy((void *)d_arr, (void *)h_arr, sizeof(float) * 128, cudaMemcpyHostToDevice);

    //lauch the kernel
    use_global_memory_GPU<<<1, 128>>>(d_arr);

    //copy data from device memory to host memory
    cudaMemcpy((void *)h_arr, (void *)d_arr, sizeof(float) * 128, cudaMemcpyDeviceToHost);

    cudaFree(d_arr);


    return 0;
}