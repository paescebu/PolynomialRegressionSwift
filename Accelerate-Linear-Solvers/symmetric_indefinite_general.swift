/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Solver function for symmetric indefinite tridiagonal matrices.
*/


import Accelerate

/// Returns the _x_ in _Ax = b_ for a nonsquare coefficient matrix using `ssysv_`.
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

/// - Tag: symmetric_indefinite_general
func symmetric_indefinite_general(a: [Float],
                                  dimension: Int,
                                  b: [Float],
                                  rightHandSideCount: Int) -> [Float]? {
    
    /// Create mutable copies of the parameters
    /// to pass to the LAPACK routine.
    var uplo = Int8("U".utf8.first!)
    var n = __CLPK_integer(dimension)
    var lda = n
    var work = __CLPK_real(0)
    var lwork = __CLPK_integer(-1)
    var info: __CLPK_integer = 0

    /// Create a mutable copy of `a` to pass to the LAPACK routine. The routine overwrites `mutableA`
    /// with the block diagonal matrix `D` and the multipliers that obtain the factor `U`.
    var mutableA = a
    
    var ipiv = [__CLPK_integer](repeating: 0, count: dimension)
    
    /// Create a mutable copy of `a` to pass to the LAPACK routine. The routine overwrites `mutableA`
    /// with the block diagonal matrix `D` and the multipliers that obtain the factor `U`.
    mutableA = a
    var nrhs = __CLPK_integer(rightHandSideCount)
    var x = b
    var ldb = n
    work = __CLPK_real(0)
    lwork = __CLPK_integer(-1)
    
    /// Pass `lwork = -1` to `ssysv_` to perform a workspace query that calculates the
    /// optimal size of the `work` array.
    ssysv_(&uplo, &n, &nrhs, &mutableA, &lda, &ipiv,
           &x, &ldb, &work, &lwork, &info)
    
    lwork = __CLPK_integer(work)
    
    /// Call `ssysv_` to compute the solution.
    _ = [__CLPK_real](unsafeUninitializedCapacity: Int(lwork)) {
        workspaceBuffer, workspaceInitializedCount in
        
        ssysv_(&uplo, &n, &nrhs, &mutableA, &lda, &ipiv, &x, &ldb,
               workspaceBuffer.baseAddress,
               &lwork, &info)
        
        workspaceInitializedCount = Int(lwork)
    }
    
    if info != 0 {
        NSLog("symmetric_indefinite_general error \(info)")
        return nil
    }
    return x
}
