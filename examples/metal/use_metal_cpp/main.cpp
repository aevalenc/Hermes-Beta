/*
 * main
 *
 * Author: Alejandro Valencia
 * Update: July 26 2025
 *
 */

#define MTL_PRIVATE_IMPLEMENTATION
#define CA_PRIVATE_IMPLEMENTATION
#define NS_PRIVATE_IMPLEMENTATION

#include <Foundation/Foundation.hpp>
#include <Metal/Metal.hpp>
#include <iostream>

int main(int argc, const char* argv[])
{

    // Intialize problem size and arrays
    const unsigned int array_size = 4;
    float a[array_size];
    float b[array_size];
    float result[array_size];
    for (unsigned int i = 0; i < array_size; ++i)
    {
        a[i] = static_cast<float>(i);
        b[i] = static_cast<float>(i * 2);
    }

    // Create Metal objects
    MTL::Device* device = MTL::CreateSystemDefaultDevice();
    const auto command_queue = device->newCommandQueue();
    const auto library_name = NS::String::string("examples/metal/add_arrays/default.metallib", NS::ASCIIStringEncoding);

    // Create Metal library from data
    NS::Error* error = nullptr;
    MTL::Library* gpu_function_library = device->newLibrary(library_name, &error);
    if (!gpu_function_library)
    {
        std::cerr << "Failed to create Metal library: "
                  << (error ? error->localizedDescription()->utf8String() : "Unknown error") << std::endl;
        return -1;
    }

    // Now you can get your kernel function from 'library'
    const auto kernel_name = NS::String::string("add_arrays", NS::ASCIIStringEncoding);
    const auto kernel_function = gpu_function_library->newFunction(kernel_name);

    NS::Error* compute_pipeline_state_error = nullptr;
    const auto compute_pipeline_state = device->newComputePipelineState(kernel_function, &compute_pipeline_state_error);
    if (compute_pipeline_state_error)
    {
        std::cerr << "Error creating compute pipeline state: "
                  << compute_pipeline_state_error->localizedDescription()->utf8String() << std::endl;
        return -1;
    }

    // Create buffers
    const auto a_buffer = device->newBuffer(a, array_size * sizeof(float), MTL::ResourceStorageModeShared);
    const auto b_buffer = device->newBuffer(b, array_size * sizeof(float), MTL::ResourceStorageModeShared);
    const auto result_buffer = device->newBuffer(result, array_size * sizeof(float), MTL::ResourceStorageModeShared);

    const auto command_buffer = command_queue->commandBuffer();
    const auto compute_command_encoder = command_buffer->computeCommandEncoder();
    compute_command_encoder->setComputePipelineState(compute_pipeline_state);

    compute_command_encoder->setBuffer(a_buffer, 0, 0);
    compute_command_encoder->setBuffer(b_buffer, 0, 1);
    compute_command_encoder->setBuffer(result_buffer, 0, 2);

    MTL::Size grid_size(array_size, 1, 1);
    MTL::Size thread_group_size(64, 1, 1);
    compute_command_encoder->dispatchThreads(grid_size, thread_group_size);

    compute_command_encoder->endEncoding();
    command_buffer->commit();
    command_buffer->waitUntilCompleted();

    // Read back the result
    const float* result_data = static_cast<const float*>(result_buffer->contents());

    std::cout << "Result: ";
    for (unsigned int i = 0; i < array_size; ++i)
    {
        std::cout << result_data[i] << " ";
    }
    std::cout << "\n";

    return 0;
}
