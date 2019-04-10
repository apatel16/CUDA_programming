// Square numbers parallely on GPU

#include <stdio.h>

// Kernel function which executes on GPU
__global__ void square(float *d_out, float *d_in)
{
   int idx = threadIdx.x;
   float f = d_in[idx];
   d_out[idx] = f * f;
}

int main()
{
	const int ARRAY_SIZE = 1024;
	const int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);

	float h_in[ARRAY_SIZE];
	for(int i = 0; i < ARRAY_SIZE; i++){
		h_in[i] = float(i);
	}
	
	float h_out[ARRAY_SIZE];

	float *d_in;
	float *d_out;

	//allocate memory on GPU device
	cudaMalloc((void **) &d_in, ARRAY_BYTES);
	cudaMalloc((void **) &d_out, ARRAY_BYTES);

	//copy input data in h_in from host to GPU
	cudaMemcpy(d_in, h_in, ARRAY_BYTES, cudaMemcpyHostToDevice);

	//execute function in GPU
	square<<< 1, ARRAY_SIZE>>>(d_out, d_in);

	//Copy result back to host from device into h_out array
	cudaMemcpy(h_out, d_out, ARRAY_BYTES, cudaMemcpyDeviceToHost);

	for(int i = 0; i < ARRAY_SIZE; i++){
		printf("%f", h_out[i]);
	    printf(((i % 4) != 3) ? "\t" : "\n");
	}

	//Free allocated memory by GPU
	cudaFree(d_in);
	cudaFree(d_out);

	return 0;
}
