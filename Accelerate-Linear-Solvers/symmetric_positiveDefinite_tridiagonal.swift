/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Solver function for symmetric positive definite tridiagonal matrices.
*/


import Accelerate

/// Returns the _x_ in _Ax = b_ for a square coefficient matrix using `sptsv_`.
///
/// - Parameter diagonalElements: The diagonal elements of matrix _A_ that
/// contain `dimension` elements.
/// - Parameter subdiagonalElements: The subdiagonal elements of matrix _A_ that
/// contain `dimension - 1` elements.
/// - Parameter dimension: The order of matrix _A_.
/// - Parameter b: The matrix _b_ in _Ax = b_ that contains `dimension * rightHandSideCount`
/// elements.
/// - Parameter rightHandSideCount: The number of columns in _b_.
///
/// The function specifies the leading dimension (the increment between successive columns of a matrix)
/// of matrices as their number of rows.

/// - Tag: symmetric_positiveDefinite_tridiagonal
func symmetric_positiveDefinite_tridiagonal(diagonalElements: [Float],
                                            subdiagonalElements: [Float],
                                            dimension: Int,
                                            b: [Float],
                                            rightHandSideCount: Int) -> [Float]? {
    
    /// Create mutable copies of the parameters to pass to the LAPACK routine.
    var n = __CLPK_integer(dimension)
    var nrhs = __CLPK_integer(rightHandSideCount)
    var x = b
    var ldb = __CLPK_integer(dimension)
    var info: __CLPK_integer = 0
    
    /// Create a mutable copy of `diagonalElements` to pass to the LAPACK routine. The routine
    /// overwrites `d` with the `n` diagonal elements of the diagonal matrix `D` from the factorization `A = L*D*Lᵀ`.
    var d = diagonalElements
    
    /// Create a mutable copy of `subdiagonalElements` to pass to the LAPACK routine. The routine
    /// overwrites `e` with the `(n-1)` subdiagonal elements of the unit bidiagonal factor `L` from
    /// the `L*D*Lᵀ` factorization of  `A`.
    var e = subdiagonalElements
    
    /// Call `sptsv_` to compute the solution.
    sptsv_(&n, &nrhs,
           &d,
           &e,
           &x,
           &ldb,
           &info)
    
    if info != 0 {
        NSLog("symmetric_positiveDefinite_tridiagonal error \(info)")
        return nil
    }
    return x
}
