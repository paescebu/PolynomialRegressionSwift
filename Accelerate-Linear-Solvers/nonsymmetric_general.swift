/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Solver function for nonsymmetric general matrices.
*/


import Accelerate

/// Returns the _x_ in _Ax = b_ for a nonsquare coefficient matrix using `sgesv_`.
///
/// - Parameter a: The matrix _A_ in _Ax = b_ that contains `dimension * dimension`
/// elements.
/// - Parameter dimension: The order of matrix _A_.
/// - Parameter b: The matrix _b_ in _Ax = b_ that contains `dimension * rightHandSideCount`
/// elements.
/// - Parameter rightHandSideCount: The number of columns in _b_.
///
/// The function specifies the leading dimension (the increment between successive columns of a matrix)
/// of matrices as their number of rows.

/// - Tag: nonsymmetric_general
func nonsymmetric_general(a: [Float],
                          dimension: Int,
                          b: [Float],
                          rightHandSideCount: Int) -> [Float]? {
  
    /// Create mutable copies of the parameters
    /// to pass to the LAPACK routine.
    var n = __CLPK_integer(dimension)
    var lda = n

    /// Create a mutable copy of `a` to pass to the LAPACK routine. The routine overwrites `mutableA`
    /// with the factors `L` and `U` from the factorization `A = P * L * U`.
    var mutableA = a
    
    var info: __CLPK_integer = 0
    
    var ipiv = [__CLPK_integer](repeating: 0, count: dimension)
    
    var nrhs = __CLPK_integer(rightHandSideCount)
    mutableA = a
    var ldb = n
    var x = b
    
    /// Call `sgesv_` to compute the solution.
    sgesv_(&n, &nrhs, &mutableA, &lda,
           &ipiv, &x, &ldb, &info)
    
    if info != 0 {
        NSLog("nonsymmetric_general error \(info)")
        return nil
    }
    return x
}
