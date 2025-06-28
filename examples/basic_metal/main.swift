import MetalKit

let count: Int = 5

var array_1: [Float] = [1.0, 2.0, 3.0, 4.0, 5.0]
var array_2 = [Float](repeating: 2.0, count: count)
// var result

print(array_1)
print(array_2)

// The GPU we want to use
let device = MTLCreateSystemDefaultDevice()

// A fifo queue for sending commands to the gpu
let commandQueue = device?.makeCommandQueue()

// A library for getting our metal functions
let gpuFunctionLibrary = device?.makeDefaultLibrary()

// Grab our gpu function
let additionGPUFunction = gpuFunctionLibrary?.makeFunction(name: "add_arrays")

var additionComputePipelineState: MTLComputePipelineState!
do {
  additionComputePipelineState = try device?.makeComputePipelineState(
    function: additionGPUFunction!)
} catch {
  print(error)
}

print()
print("GPU Way")

// Create the buffers to be sent to the gpu from our arrays
let arr1Buff = device?.makeBuffer(
  bytes: array_1,
  length: MemoryLayout<Float>.size * count,
  options: .storageModeShared)

let arr2Buff = device?.makeBuffer(
  bytes: array_2,
  length: MemoryLayout<Float>.size * count,
  options: .storageModeShared)

let resultBuff = device?.makeBuffer(
  length: MemoryLayout<Float>.size * count,
  options: .storageModeShared)

print("GPU Buffers Created")

// Create a buffer to be sent to the command queue
let commandBuffer = commandQueue?.makeCommandBuffer()

// Create an encoder to set vaules on the compute function
let commandEncoder = commandBuffer?.makeComputeCommandEncoder()
commandEncoder?.setComputePipelineState(additionComputePipelineState)

// Set the parameters of our gpu function
commandEncoder?.setBuffer(arr1Buff, offset: 0, index: 0)
commandEncoder?.setBuffer(arr2Buff, offset: 0, index: 1)
commandEncoder?.setBuffer(resultBuff, offset: 0, index: 2)

// Figure out how many threads we need to use for our operation
let threadsPerGrid = MTLSize(width: count, height: 1, depth: 1)
let maxThreadsPerThreadgroup = additionComputePipelineState.maxTotalThreadsPerThreadgroup  // 1024
let threadsPerThreadgroup = MTLSize(width: maxThreadsPerThreadgroup, height: 1, depth: 1)
commandEncoder?.dispatchThreads(
  threadsPerGrid,
  threadsPerThreadgroup: threadsPerThreadgroup)

// Tell the encoder that it is done encoding.  Now we can send this off to the gpu.
commandEncoder?.endEncoding()

// Push this command to the command queue for processing
commandBuffer?.commit()

// Wait until the gpu function completes before working with any of the data
commandBuffer?.waitUntilCompleted()

// Get the pointer to the beginning of our data
var resultBufferPointer = resultBuff?.contents().bindMemory(
  to: Float.self,
  capacity: MemoryLayout<Float>.size * count)

// Print out all of our new added together array information
for i in 0..<count {
  print("\(array_1[i]) + \(array_2[i]) = \(Float(resultBufferPointer!.pointee) as Any)")
  resultBufferPointer = resultBufferPointer?.advanced(by: 1)
}
