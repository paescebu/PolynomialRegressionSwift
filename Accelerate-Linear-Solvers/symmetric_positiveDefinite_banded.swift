/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Solver function for symmetric positive definite banded matrices.
*/


import Accelerate

/// Returns the _x_ in _Ax = b_ for a symmetric, positive definite, banded coefficient matrix using `spbsv_`.
///
/// - Parameter aBanded: The upper triangle of _A_ in _Ax = b_.
/// - Parameter dimension: The order of matrix _A_.
/// - Parameter superdiagonalCount: The number of superdiagonals of _A_.
/// - Parameter b: The matrix _b_ in _Ax = b_ that contains `dimension * rightHandSideCount`
/// elements.
/// - Parameter rightHandSideCount: The number of columns in _b_.
///
/// The following example illustrates the band storage scheme when `N = 6`, `KD = 2`, and
/// `UPLO = 'U'`:
///
///     On entry:                        On exit:
///
///      *    *   a13  a24  a35  a46      *    *   u13  u24  u35  u46
///      *   a12  a23  a34  a45  a56      *   u12  u23  u34  u45  u56
///     a11  a22  a33  a44  a55  a66     u11  u22  u33  u44  u55  u66
///
/// The routine doesn’t use array elements with `*` marks.
///
/// The function specifies the leading dimension (the increment between successive columns of a matrix)
/// of matrices as their number of rows.

/// - Tag: symmetric_positiveDefinite_banded
func symmetric_positiveDefinite_banded(aBanded: [Float],
                                       dimension: Int,
                                       superdiagonalCount: Int,
                                       b: [Float],
                                       rightHandSideCount: Int) -> [Float]? {
    
    /// Specify upper triangle.
    var uplo = Int8("U".utf8.first!)
    
    /// Create mutable copies of the parameters to pass to the LAPACK routine.
    var n = __CLPK_integer(dimension)
    var kd = __CLPK_integer(superdiagonalCount)
    var ldab = kd + 1
    var nrhs = __CLPK_integer(rightHandSideCount)
    var x = b
    var ldb = __CLPK_integer(dimension)
    var info: __CLPK_integer = 0
    
    /// Create a mutable copy of `aBanded` to pass to the LAPACK routine. The routine
    /// overwrites `mutableAb` with the triangular factor `U` from the Cholesky factorization `A = Uᵀ*U`.
    var mutableAb = aBanded
    
    /// Call `spbsv_` to compute the solution.
    spbsv_(&uplo,
           &n,
           &kd,
           &nrhs,
           &mutableAb,
           &ldab,
           &x,
           &ldb,
           &info)
    
    if info != 0 {
        NSLog("symmetric_positiveDefinite_banded error \(info)")
        return nil
    }
    return x
}
