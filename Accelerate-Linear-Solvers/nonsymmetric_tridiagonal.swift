/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Solver function for nonsymmetric tridiagonal matrices.
*/


import Accelerate

/// Returns the _x_ in _Ax = b_ for a nonsquare coefficient matrix using `sgtsv_`.
///
/// - Parameter subdiagonalElements: The subdiagonal elements of matrix _A_ that
/// contain `diagonalElements.count - 1` elements.
/// - Parameter diagonalElements: The diagonal elements of matrix _A_.
/// - Parameter superdiagonalElements: The subdiagonal elements of matrix _A_ that
/// contain `diagonalElements.count - 1` elements.
/// - Parameter b: The matrix _b_ in _Ax = b_ that contains `dimension * rightHandSideCount`
/// elements.
/// - Parameter rightHandSideCount: The number of columns in _b_.
///
/// The function specifies the leading dimension (the increment between successive columns of a matrix)
/// of matrices as their number of rows.

/// - Tag: nonsymmetric_tridiagonal
func nonsymmetric_tridiagonal(subdiagonalElements: [Float],
                              diagonalElements: [Float],
                              superdiagonalElements: [Float],
                              b: [Float],
                              rightHandSideCount: Int) -> [Float]? {
    
    /// Create mutable copies of the parameters
    /// to pass to the LAPACK routine.
    var n = __CLPK_integer(diagonalElements.count)
    var nrhs = __CLPK_integer(rightHandSideCount)
    var x = b
    var ldb = __CLPK_integer(diagonalElements.count)
    var info: __CLPK_integer = 0

    /// Create a mutable copy of `subdiagonalElements` to pass to the LAPACK routine. The routine
    /// overwrites `dl` with the `n - 2` elements of the second superdiagonal of the upper triangular
    /// matrix `U` from the LU factorization of `A`, in `DL(1), ..., DL(n-2)`.
    var dl = subdiagonalElements

    /// Create a mutable copy of `diagonalElements` to pass to the LAPACK routine. The routine
    /// overwrites `d` with the `n` diagonal elements of `U`.
    var d = diagonalElements
    
    /// Create a mutable copy of `superdiagonalElements` to pass to the LAPACK routine. The routine
    /// overwrites `du` with the `(n-1)` elements of the first superdiagonal of `U`.
    var du = superdiagonalElements
    
    /// Call `sgtsv_` to compute the solution.
    sgtsv_(&n,
           &nrhs,
           &dl,
           &d,
           &du,
           &x,
           &ldb,
           &info)
    
    if info != 0 {
        NSLog("nonsymmetric_tridiagonal error \(info)")
        return nil
    }
    return x
}
