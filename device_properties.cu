#include <stdio.h>

int main(){
    void printCudaDeviceProperties(void);

    printCudaDeviceProperties();
    return 0;
}

//ToDo - Get the information about gpu device
void printCudaDeviceProperties(){

    //function declaration
    int ConvertSMVersionNumberToCores(int, int);

    printf("Cuda Information :\n");
    printf("==============================================================\n");

    cudaError_t ret_cuda_rt;
    int dev_count;
    
    ret_cuda_rt = cudaGetDeviceCount(&dev_count);
    if(ret_cuda_rt != cudaSuccess){
        printf("Cuda runtime API Error - cudaGetDeviceCount() failed due to %s. Exitting Now ...\n", cudaGetErrorString(ret_cuda_rt));
    }
    else if(dev_count == 0){
        printf("No CUDA supported device on system.\n");
        return ;
    }
    else{
        printf("Total number of cuda supporting GPU devices on the system : %d\n", dev_count);
        
        // Print properties of each device
        for (int i = 0; i < dev_count; i++){
            cudaDeviceProp dev_prop;
            int driverVersion = 0; 
            int runtimeVersion = 0;

            ret_cuda_rt = cudaGetDeviceProperties(&dev_prop, i);
            if(ret_cuda_rt != cudaSuccess){
                printf("%s in %s at line %d\n", cudaGetErrorString(ret_cuda_rt), __FILE__, __LINE__);
                return;
            }

            printf("\n");
            cudaDriverGetVersion(&driverVersion);
            cudaRuntimeGetVersion(&runtimeVersion);

            printf("CUDA DRIVER AND RUNTIME INFORMATIO\n");
            printf("=================================================\n");
            printf("Cuda driver  version     : %d.%d\n", driverVersion/1000, (driverVersion % 100)/10);
            printf("Cuda runtime version     : %d.%d\n", runtimeVersion/1000, (runtimeVersion % 100)/10);

        }
    }


}

int ConvertSMVersionNumberToCores(int major, int minor){

    return 0;
}