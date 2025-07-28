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

#include <Metal/Metal.hpp>
#include <iostream>

int main(int argc, const char* argv[])
{
    MTL::Device* device = MTL::CreateSystemDefaultDevice();
    std::cout << "Device name: " << device->name() << "\n";

    return 0;
}
