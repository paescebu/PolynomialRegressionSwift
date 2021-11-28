/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Solver function for nonsymmetric nonsquare matrices.
*/


import Accelerate

/// Returns the _x_ in _Ax = b_ for a nonsquare coefficient matrix using `sgels_`.
///
/// - Parameter a: The matrix _A_ in _Ax = b_ that contains `dimension.m * dimension.n`
/// elements.
/// - Parameter dimension: The number of rows and columns of matrix _A_.
/// - Parameter b: The matrix _b_ in _Ax = b_ that contains `dimension * rightHandSideCount`
/// elements.
/// - Parameter rightHandSideCount: The number of columns in _b_.
///
/// If the system is overdeterrmined (that is, there are more rows than columns in the coefficient matrix), the
/// sum of squares of the returned elements in rows `n ..< m`is the residual sum of squares
/// for the solution.
///
/// The function specifies the leading dimension (the increment between successive columns of a matrix)
/// of matrices as their number of rows.

/// - Tag: nonsymmetric_nonsquare
func nonsymmetric_nonsquare(a: [Float],
                            dimension: (m: Int,
                                        n: Int),
                            b: [Float],
                            rightHandSideCount: Int) -> [Float]? {
    
    /// Specify no transpose.
    var trans = Int8("N".utf8.first!)
    
    /// Create mutable copies of the parameters to pass to the LAPACK routine.
    var m = __CLPK_integer(dimension.m)
    var n = __CLPK_integer(dimension.n)
    var nrhs = __CLPK_integer(rightHandSideCount)
    
    /// Create a mutable copy of `a` to pass to the LAPACK routine. The routine overwrites `mutableA`
    /// with details of its QR or LQ factorization.
    var mutableA = a
    var lda = m
    var ldb = max(m, n)
    var work = __CLPK_real(0)
    var lwork = __CLPK_integer(-1)
    var info: __CLPK_integer = 0
    
    /// Call `slacpy_` to copy the values of `m * nrhs` matrix `b` into the `ldb * nrhs`
    /// result matrix `x`.
    let xCount = Int(ldb * nrhs)
    var x = [Float](unsafeUninitializedCapacity: xCount) {
        buffer, initializedCount in
        var uplo = Int8("A".utf8.first!)
        var mutableB = b
        
        slacpy_(&uplo, &m, &nrhs, &mutableB, &lda,
                buffer.baseAddress,
                &ldb)
        
        initializedCount = xCount
    }

    /// Pass `lwork = -1` to `sgels_` to perform a workspace query that calculates the optimal
    /// size of the `work` array.
    sgels_(&trans, &m, &n, &nrhs, &mutableA, &lda,
           &x, &ldb, &work, &lwork, &info)
    
    lwork = __CLPK_integer(work)
    
    /// Call `sgels_` to compute the solution.
    _ = [__CLPK_real](unsafeUninitializedCapacity: Int(lwork)) {
        workspaceBuffer, workspaceInitializedCount in
        
        sgels_(&trans, &m, &n, &nrhs, &mutableA, &lda, &x, &ldb,
               workspaceBuffer.baseAddress,
               &lwork, &info)
        
        workspaceInitializedCount = Int(lwork)
    }
    
    if info != 0 {
        NSLog("nonsymmetric_nonsquare error \(info)")
        return nil
    }
    
    return x
}
