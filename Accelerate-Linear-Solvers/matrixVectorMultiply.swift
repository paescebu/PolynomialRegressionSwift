/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Function to return the result of multiplying a matrix by a vector.
*/

import Accelerate

/// Returns the result of `matrix * vector`.
func matrixVectorMultiply(matrix: [Float],
                          dimension: (m: Int, n: Int),
                          vector: [Float]) -> [Float] {
    
    let result = [Float](unsafeUninitializedCapacity: dimension.m) {
        buffer, initializedCount in
        
        cblas_sgemv(CblasColMajor, CblasNoTrans,
                    Int32(dimension.m),
                    Int32(dimension.n),
                    1, matrix, Int32(dimension.m),
                    vector, 1, 0,
                    buffer.baseAddress, 1)
        
        initializedCount = dimension.m
    }
    
    return result
}
