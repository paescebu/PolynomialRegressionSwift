/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Function to determine whether a specified matrix is positive definite.
*/


import Accelerate

/// Returns a Boolean value that indicates whether the specified matrix is positive definite, and
/// if the matrix is positive definite, the Cholesky factorization
func isPositiveDefinite(_ matrix: [Float],
                        dimension: Int) -> (isPositiveDefinite: Bool,
                                            factorization: [Float]) {
    
    /// Specify upper triangle.
    var uplo = Int8("U".utf8.first!)
    
    /// Create mutable copies of the parameters
    /// to pass to the LAPACK routine.
    var n = __CLPK_integer(dimension)
    var a = matrix
    var lda = n
    var info = __CLPK_integer(0)
   
    /// Call `spotrf_` to compute the Cholesky
    /// factorization of the specified matrix.
    spotrf_(&uplo,
            &n,
            &a,
            &lda,
            &info)

    /// If `info` is greater than 0, the specified matrix
    /// isn't positive definite.
    return (isPositiveDefinite: info <= 0,
            factorization: a)
}
