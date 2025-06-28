/*
 * add_arrays.metal
 * Author: Alejandro Valencia
 * Update: June 26, 2025
*/
#include <metal_stdlib>

/// @brief Adds two input arrays element-wise and stores the result in the output array
///
/// @param a The first input array
/// @param b The second input array
/// @param result The output array to store the result
/// @param id The index of the current thread
///
/// @returns void
kernel void add_arrays(constant float *a [[buffer(0)]],
                  constant float *b [[buffer(1)]],
                  device float *result [[buffer(2)]],
                  uint id [[thread_position_in_grid]]) {
    result[id] = a[id] + b[id];
}
