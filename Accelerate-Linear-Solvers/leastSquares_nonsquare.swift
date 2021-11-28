/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Solver function for nonsymmetric nonsquare matrices using least squares.
*/


import Accelerate

/// Returns the _x_ in _Ax = b_ for a nonsquare coefficient matrix using least squares.
///
///
/// - Parameter a: The matrix _A_ in _Ax = b_ that contains `dimension.m * dimension.n`
/// elements.
/// - Parameter dimension: The number of rows and columns of matrix _A_.
/// - Parameter b: The matrix _b_ in _Ax = b_ that contains `dimension.n` elements.
///
/// The function exploits the fact that the _x_ in _AᵀAx = Aᵀb_ equals _Ax = b_ by creating the square
/// coefficient matrix _AᵀA_ and solving with either
/// `symmetric_positiveDefinite_general(a:dimension:b:rightHandSideCount:)`
/// or `symmetric_indefinite_general(a:dimension:b:rightHandSideCount:)`.
///
/// The function creates _AᵀA_ using the BLAS function `cblas_ssyrk(_:_:_:_:_:_:_:_:_:_:_:)`
/// and selects the correct solve function by attempting a Cholesky factorization of _AᵀA_  to determine
/// whether it's positive definite.
///
/// The function specifies the leading dimension (the increment between successive columns of a matrix)
/// of matrices as their number of rows.

/// - Tag: leastSquares_nonsquare
func leastSquares_nonsquare(a: [Float],
                            dimension: (m: Int,
                                        n: Int),
                            b: [Float]) -> [Float]? {
    
    /// Create mutable copies of the parameters to pass to the LAPACK routine.
    let m = Int32(dimension.m)
    var n = Int32(dimension.n)
    
    /// _AᵀA_ is an _A_ columns x _A_ columns matrix.
    let ataCount = dimension.n * dimension.n
    
    /// Call `cblas_ssyrk` to create _AᵀA_.
    let ata = [Float](unsafeUninitializedCapacity: ataCount) {
        buffer, initializedCount in
        
        cblas_ssyrk(CblasColMajor, CblasUpper, CblasTrans,
                    n,
                    m,
                    1, a, m,
                    0, buffer.baseAddress, n)
        
        initializedCount = ataCount
    }
    
    /// Call `cblas_sgemv` to create _Aᵀb_.
    var atb = [Float](unsafeUninitializedCapacity: dimension.n) {
        buffer, initializedCount in
        
        cblas_sgemv(CblasColMajor, CblasTrans,
                    m,
                    n,
                    1, a, m,
                    b, 1, 0,
                    buffer.baseAddress, 1)
        
        initializedCount = dimension.n
    }
    
    let x: [Float]?
    
    var isPositiveDefiniteResult = isPositiveDefinite(ata, dimension: dimension.n)
    
    /// Call the appropriate symmetric solve function.
    if isPositiveDefiniteResult.isPositiveDefinite {
        /// Use the successful factorization returned by `spotrf_` in `isPositiveDefinite` to
        /// solve the system. Computing the factorization with `spotrf_` and solving using that
        /// factorization with `spotrs_` is the same process used by the `sposv_` routine that
        /// `symmetric_positiveDefinite_general` wraps.
        
        var uplo = Int8("U".utf8.first!)
        var nrhs = __CLPK_integer(1)
        var lda = n
        var ldb = n
        var info: __CLPK_integer = 0
        
        spotrs_(&uplo,
                &n,
                &nrhs,
                &isPositiveDefiniteResult.factorization,
                &lda,
                &atb,
                &ldb,
                &info)
        
        x = atb
    } else {
        x = symmetric_indefinite_general(a: ata,
                                         dimension: dimension.n,
                                         b: atb,
                                         rightHandSideCount: 1)
    }
    
    return x
}
