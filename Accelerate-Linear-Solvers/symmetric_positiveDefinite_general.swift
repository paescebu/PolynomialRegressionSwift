/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Solver function for symmetric positive definite general matrices.
*/


import Accelerate

/// Returns the _x_ in _Ax = b_ for a nonsquare coefficient matrix using `sposv_`.
///
/// - Parameter a: The matrix _A_ in _Ax = b_ that contains `dimension * dimension`
/// elements. The function references the upper triangle of _A_.
/// - Parameter dimension: The order of matrix _A_.
/// - Parameter b: The matrix _b_ in _Ax = b_ that contains `dimension * rightHandSideCount`
/// elements.
/// - Parameter rightHandSideCount: The number of columns in _b_.
///
/// The function specifies the leading dimension (the increment between successive columns of a matrix)
/// of matrices as their number of rows.

/// - Tag: symmetric_positiveDefinite_general
func symmetric_positiveDefinite_general(a: [Float],
                                        dimension: Int,
                                        b: [Float],
                                        rightHandSideCount: Int) -> [Float]? {
    
    /// Create mutable copies of the parameters to pass to the LAPACK routine.
    var uplo = Int8("U".utf8.first!)
    var n = __CLPK_integer(dimension)
    var nrhs = __CLPK_integer(rightHandSideCount)
    
    var lda = n
    var ldb = n
    var x = b
    var info: __CLPK_integer = 0
    
    /// Create a mutable copy of `a` to pass to the LAPACK routine. The routine overwrites `mutableA`
    /// with  the factor `U` from the Cholesky factorization `A = Uᵀ*U`.
    var mutableA = a
    
    /// Call `sposv_` to compute the solution.
    sposv_(&uplo,
           &n,
           &nrhs,
           &mutableA,
           &lda,
           &x,
           &ldb,
           &info)
    
    if info != 0 {
        NSLog("symmetric_positiveDefinite_general error \(info)")
        return nil
    }
    return x
}
