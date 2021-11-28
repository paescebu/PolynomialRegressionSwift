/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Main Swift file for LAPACK linear solvers sample.
*/


import Foundation
import Accelerate

let bValues: [Float] = [80, 180, 160,
                        800, 1800, 1600]

/// The following code calls `symmetric_positiveDefinite_tridiagonal()` to compute the values
/// of _x_. Because the matrix is symmetric, the subdiagonal and superdiagonal contain identical values and
/// the function only requires one set of values.
do {
    /// Compute the _x_ in _Ax = b_ with the following system:
    ///
    ///     [3, 1, 0,       [10,        [50,
    ///      1, 4, 2,   ·    20,    =    150,
    ///      0, 2, 5]        30]         190]
    
    /// The superdiagonal and the subdiagonal of matrix A.
    let subdiagonalElements: [Float] = [1, 2]
    /// The diagonal of matrix A.
    let diagonalElements: [Float] = [3, 4, 5]
    
    /// The _b_ in _Ax = b_ with _x_ = `[10.0, 20.0, 30.0]`.
    let bValues: [Float] = [50, 150, 190]
    
    /// Call `symmetric_positiveDefinite_tridiagonal` to compute the _x_ in _Ax = b_.
    let x = symmetric_positiveDefinite_tridiagonal(diagonalElements: diagonalElements,
                                                   subdiagonalElements: subdiagonalElements,
                                                   dimension: 3,
                                                   b: bValues,
                                                   rightHandSideCount: 1)
    /// Prints `~[10.0, 20.0, 30.0]`.
    print("\nsymmetric_positiveDefinite_tridiagonal: x =", x ?? [])
}

/// The following code calls `symmetric_positiveDefinite_banded()` to compute the values of
/// _x_. Because the matrix is symmetric, the subdiagonals and superdiagonals contain identical values and
/// the function only requires one set of values.
do {
    /// Compute the _x_ in _Ax = b_ with the following system:
    ///
    ///     [ 3, 1, -1,       [10,        [ 20,
    ///       1, 4,  2,   ·    20,    =    150,
    ///      -1, 2,  5]        30]         180]
    
    /// The upper triangle of matrix A (`superdiagonalCount + 1` x ` dimension`).
    let abValues: [Float] = [ 0, 0, 3,
                              0, 1, 4,
                             -1, 2, 5]
    
    /// The _b_ in _Ax = b_ with _x_ = `[10.0, 20.0, 30.0]`.
    let bValues: [Float] = [20, 150, 180]
    
    /// Call `symmetric_positiveDefinite_banded` to compute the _x_ in _Ax = b_.
    let x = symmetric_positiveDefinite_banded(aBanded: abValues,
                                              dimension: 3,
                                              superdiagonalCount: 2,
                                              b: bValues,
                                              rightHandSideCount: 1)
    
    /// Prints `~[10.0, 20.0, 30.0]`.
    print("\nsymmetric_positiveDefinite_banded: x =", x ?? [])
}

/// The following code calls `symmetric_positiveDefinite_general()` to compute the values of
/// _x_. Because the matrix is symmetric and the Swift wrapper function specifies that the LAPACK routine
/// should reference the upper triangle, the code fills the lower triangle of `aValues` with zeros.
do {
    /// Compute the _x_ in _Ax = b_ with the following system:
    ///
    ///     [ 3, 1, -1,       [10,        [ 20,
    ///       1, 4,  2,   ·    20,    =    150,
    ///      -1, 2,  5]        30]         180]
    
    /// The values of matrix A.
    let aValues: [Float] = [ 3, 0, 0,
                             1, 4, 0,
                            -1, 2, 5]
    
    /// The _b_ in _Ax = b_ with _x_ = `[10.0, 20.0, 30.0]`.
    let bValues: [Float] = [20, 150, 180]
    
    /// Call `symmetric_positiveDefinite_general` to compute the _x_ in _Ax = b_.
    let x = symmetric_positiveDefinite_general(a: aValues,
                                               dimension: 3,
                                               b: bValues,
                                               rightHandSideCount: 1)
    
    /// Prints `~[10.0, 20.0, 30.0]`.
    print("\nsymmetric_positiveDefinite_general: x =", x ?? [])
}

/// The following code calls `symmetric_indefinite_general()` to compute the values of _x_.
/// Because the matrix is symmetric and the Swift wrapper function specifies that the LAPACK routine should
/// reference the upper triangle, the code fills the lower triangle of `aValues` with zeros.
do {
    /// Compute the _x_ in _Ax = b_ with the following system:
    ///
    ///     [1, 2, 5,       [10,        [200,
    ///      2, 3, 4,   ·    20,    =    200,
    ///      5, 4, 2]        30]         190]
    
    /// The values of matrix A.
    let aValues: [Float] = [1, 0, 0,
                            2, 3, 0,
                            5, 4, 2]
    
    /// The _b_ in _Ax = b_ with _x_ = `[10.0, 20.0, 30.0]`.
    let bValues: [Float] = [200, 200, 190]
    
    /// Call `symmetric_indefinite_general` to compute the _x_ in _Ax = b_.
    let x = symmetric_indefinite_general(a: aValues,
                                         dimension: 3,
                                         b: bValues,
                                         rightHandSideCount: 1)
    
    /// Prints `~[10.0, 20.0, 30.0]`.
    print("\nsymmetric_indefinite_general: x =", x ?? [])
}

/// The following code calls `nonsymmetric_tridiagonal()` to compute the values of _x_:
do {
    /// Compute the _x_ in _Ax = b_ with the following system:
    ///
    ///     [3, 1, 0,       [10,        [ 50,
    ///      6, 4, 2,   ·    20,    =    200,
    ///      0, 7, 5]        30]         290]
    
    let superdiagonalElements: [Float] = [1, 2]
    let diagonalElements: [Float] = [3, 4, 5]
    let subdiagonalElements: [Float] = [6, 7]
    
    /// The _b_ in _Ax = b_ with _x_ = `[10.0, 20.0, 30.0]`.
    let bValues: [Float] = [50, 200, 290]
    
    /// Call `nonsymmetric_tridiagonal` to compute the _x_ in _Ax = b_.
    let x = nonsymmetric_tridiagonal(subdiagonalElements: subdiagonalElements,
                                     diagonalElements: diagonalElements,
                                     superdiagonalElements: superdiagonalElements,
                                     b: bValues,
                                     rightHandSideCount: 1)
    
    /// Prints `~[10.0, 20.0, 30.0]`.
    print("\nnonsymmetric_tridiagonal: x =", x ?? [])
}

/// The following code calls `nonsymmetric_banded()` to compute the values of _x_:
do {
    /// Compute the _x_ in _Ax = b_ with the following system:
    ///
    ///     [11, 21, 31, 00, 00,        [10,        [350,
    ///      12, 22, 32, 42, 00,         20,         1340,
    ///      00, 23, 33, 43, 53,    ·    30,    =    3300,
    ///      00, 00, 34, 44, 54,         40,         6140,
    ///      00, 00, 00, 45, 55]         50]         6500]
    
    /// The values of matrix _A_, which the system stores as band storage with its columns in
    /// corresponding columns of the array, and its diagonals in rows of the array.
    let bandStorage: [Float] = [00, 00, 00, 11, 21, 31,
                                00, 00, 12, 22, 32, 42,
                                00, 00, 23, 33, 43, 53,
                                00, 00, 34, 44, 54, 00,
                                00, 00, 45, 55, 00, 00]
    
    let dimension = 5
    let subdiagonalCount = 2
    let superdiagonalCount = 1
    
    /// The _b_ in _Ax = b_.
    let bValues: [Float] = [350, 1340, 3300, 6140, 6500]
    
    /// Call `nonsymmetric_banded` to compute the _x_ in _Ax = b_.
    let x = nonsymmetric_banded(aBanded: bandStorage,
                                dimension: dimension,
                                subdiagonalCount: subdiagonalCount,
                                superdiagonalCount: superdiagonalCount,
                                b: bValues,
                                rightHandSideCount: 1)
    
    /// Calculate _b_ using the computed _x_.
    if let x = x {
        /// The values of _A_ as a column-major collection.
        let aValues: [Float] = [11, 21, 31, 00, 00,
                                12, 22, 32, 42, 00,
                                00, 23, 33, 43, 53,
                                00, 00, 34, 44, 54,
                                00, 00, 00, 45, 55]
        let b = matrixVectorMultiply(matrix: aValues,
                                     dimension: (m: 5, n: 5),
                                     vector: x)
        
        /// Prints _b_ in _Ax = b_  using the computed _x_: `~[350, 1340, 3300, 6140, 6500]`.
        print("\nnonsymmetric_banded: b =", b)
    }
}

/// The following code calls `nonsymmetric_general()` to compute the values of _x_:
do {
    /// Compute the _x_ in _Ax = b_ with the following system:
    ///
    ///     [1, 2, 3,       [-2,        [70,
    ///      4, 5, 6,   ·    24,    =    160,
    ///      7, 8, 9]        8]          250]
    
    let aValues: [Float] = [1, 4, 7,
                            2, 5, 8,
                            3, 6, 9]
    
    /// The _b_ in _Ax = b_.
    let bValues: [Float] = [70, 160, 250]
    
    /// Call `nonsymmetric_general` to compute the _x_ in _Ax = b_.
    let x = nonsymmetric_general(a: aValues,
                                 dimension: 3,
                                 b: bValues,
                                 rightHandSideCount: 1)
    
    /// Calculate _b_ using the computed _x_.
    if let x = x {
        let b = matrixVectorMultiply(matrix: aValues,
                                     dimension: (m: 3, n: 3),
                                     vector: x)
        
        /// Prints _b_ in _Ax = b_ using the computed _x_: `~[70, 160, 250]`.
        print("\nnonsymmetric_general: b =", b)
    }
}

do {
    /// Compute the _x_ in _Ax = b_ with the following system:
    ///
    ///                                 [  60.677,
    ///     [ 1,  2,  3,  4,  5,         -135.108,      [ 355,
    ///       6,  7,  8,  9, 10,    ·      32.217,  =     930,
    ///      11, 12, 13, 14, 15]           18.183,       1505]
    ///                                    39.0312]
    let aValues: [Float] = [1, 6, 11,
                            2, 7, 12,
                            3, 8, 13,
                            4, 9, 14,
                            5, 10, 15]
    
    let dimension = (m: 3, n: 5)
    
    /// The _b_ in _Ax = b_.
    let bValues: [Float] = [355, 930, 1505]
    
    /// Call `nonsymmetric_nonsquare` to compute the _x_ in _Ax = b_.
    let x = nonsymmetric_nonsquare(a: aValues,
                                   dimension: dimension,
                                   b: bValues,
                                   rightHandSideCount: 1)
    
    /// Calculate _b_ using the computed _x_.
    if let x = x {
        let b = matrixVectorMultiply(matrix: aValues,
                                     dimension: dimension,
                                     vector: x)
        
        /// Prints _b_ in _Ax = b_ using the computed _x_: `~[355, 930, 1505]`.
        print("\nnonsymmetric_nonsquare: ([355, 930, 1505]) b =", b)
    }
}

/// A duplicate of the `nonsymmetric_nonsquare` sample, but using `leastSquares_nonsquare`.
do {
    /// Compute the _x_ in _Ax = b_ with the following system:
    ///
    ///                                 [  60.677,
    ///     [ 1,  2,  3,  4,  5,         -135.108,      [ 355,
    ///       6,  7,  8,  9, 10,    ·      32.217,  =     930,
    ///      11, 12, 13, 14, 15]           18.183,       1505]
    ///
    let aValues: [Float] = [1, 6, 11,
                            2, 7, 12,
                            3, 8, 13,
                            4, 9, 14,
                            5, 10, 15]
    
    let dimension = (m: 3, n: 5)
    
    /// The _b_ in _Ax = b_.
    let bValues: [Float] = [355, 930, 1505]
    
    /// Call `nonsymmetric_nonsquare` to compute the _x_ in _Ax = b_.
    let x = leastSquares_nonsquare(a: aValues,
                                   dimension: dimension,
                                   b: bValues)
    
    /// Calculate _b_ using the computed _x_.
    if let x = x {
        let b = matrixVectorMultiply(matrix: aValues,
                                     dimension: dimension,
                                     vector: x)
        
        /// Prints _b_ in _Ax = b_ using the computed _x_: `~[355, 930, 1505]`.
        print("\nleastSquares_nonsquare ([355, 930, 1505]): b =", b)
    }
}

do {
    /// Compute the _x_ in _Ax = b_ with the following system:
    ///
    ///     [ 1,  2,  3,        [-31.567,       [194,
    ///       4,  5,  6,    ·    130.133    =    455,
    ///       7,  8,  9,         -11.566]        716,
    ///      10, 11, 12]                         977]
    
    let aValues: [Float] = [1, 4, 7, 10,
                            2, 5, 8, 11,
                            3, 6, 9, 12]
    let dimension = (m: 4, n: 3)
    let bValues: [Float] = [194, 455, 716, 977]
    
    /// Call `leastSquares_nonsquare` to compute the _x_ in _Ax = b_.
    let x = leastSquares_nonsquare(a: aValues,
                                   dimension: dimension,
                                   b: bValues)

    /// Calculate _b_ using the computed _x_.
    if let x = x {
        let b = matrixVectorMultiply(matrix: aValues,
                                     dimension: dimension,
                                     vector: Array(x[0..<3]))
        
        /// Prints _b_ in _Ax = b_ using the computed _x_: `~[194, 455, 716, 977]`.
        print("\nleastSquares_nonsquare: b =", b)
    }
}

/// A duplicate of the `leastSquares_nonsquare` sample, but using `nonsymmetric_nonsquare`.
do {
    /// Compute the _x_ in _Ax = b_ with the following system:
    ///
    ///     [ 1,  2,  3,        [-31.567,       [194,
    ///       4,  5,  6,    ·    130.133    =    455,
    ///       7,  8,  9,         -11.566]        716,
    ///      10, 11, 12]                         977]
    
    let aValues: [Float] = [1, 4, 7, 10,
                            2, 5, 8, 11,
                            3, 6, 9, 12]
    let dimension = (m: 4, n: 3)
    let bValues: [Float] = [194, 455, 716, 977]
    
    /// Call `leastSquares_nonsquare` to compute the _x_ in _Ax = b_.
    let x = nonsymmetric_nonsquare(a: aValues,
                                   dimension: dimension,
                                   b: bValues,
                                   rightHandSideCount: 1)

    /// Calculate _b_ using the computed _x_.
    if let x = x {
        let b = matrixVectorMultiply(matrix: aValues,
                                     dimension: dimension,
                                     vector: Array(x[0..<3]))
        
        /// Prints _b_ in _Ax = b_ using the computed _x_: `~[194, 455, 716, 977]`.
        print("\nnonsymmetric_nonsquare ([194, 455, 716, 977]): b =", b)
    }
}

/// Rank-deficient symmetric matrix with added epsilon.
do {
    /// Compute a candidate _x_ in _Ax = b_ with the following system:
    ///
    ///     [1, 2, 1,       [           [ 80,
    ///      2, 1, 2,   ·    x      =    100,
    ///      1, 2, 1]         ]           80]
    
    var aValues: [Float] = [1, 2, 1,
                            2, 1, 2,
                            1, 2, 1]

    let dimension = 3
    let epsilon = sqrt(Float.ulpOfOne)
    for i in 0 ..< dimension {
        aValues[i * dimension + i] += epsilon
    }
    
    let bValues: [Float] = [80, 100, 80]
    
    /// Call `symmetric_indefinite_general` to compute the _x_ in _Ax = b_.
    let x = symmetric_indefinite_general(a: aValues,
                                         dimension: dimension,
                                         b: bValues,
                                         rightHandSideCount: 1)
    
    /// Calculate _b_ using the computed _x_.
    if let x = x {
        let b = matrixVectorMultiply(matrix: aValues,
                                     dimension: (m: dimension, n: dimension),
                                     vector: x)
        
        /// Prints _b_ in _Ax = b_ using the computed _x_: `~[80, 100, 80]`.
        print("\nRank-Deficient: b =", b)
    }
}

do {
    let aValues: [Float] = [1, 1, 1,
                            1, -0.5, -1]
    
    let dimension = (m: 3, n: 2)
    
    /// The _b_ in _Ax = b_.
    let bValues: [Float] = [2, 2, 0]
    
    do {
        /// Call `nonsymmetric_nonsquare` to compute the _x_ in _Ax = b_.
        let x = nonsymmetric_nonsquare(a: aValues,
                                       dimension: dimension,
                                       b: bValues,
                                       rightHandSideCount: 1)
        
        /// Prints "[1.4615387, 0.7692307, -1.1766968]".
        print("\n3 x 2 nonsymmetric_nonsquare x =", x ?? [])
    }
    
    do {
        /// Call `leastSquares_nonsquare` to compute the _x_ in _Ax = b_.
        ///
        /// Note that `leastSquares_nonsquare` only returns _x_. Use `nonsymmetric_nonsquare`
        /// to calculate the residual sum of squares.
        let x = leastSquares_nonsquare(a: aValues,
                                       dimension: dimension,
                                       b: bValues)
        
        /// Prints "[1.4615387, 0.7692307]".
        print("\n3 x 2 leastSquares_nonsquare x =", x ?? [])
    }
}

do {
    let aValues: [Float] = [-1, 1]
    
    let dimension = (m: 1, n: 2)
    
    /// The _b_ in _Ax = b_.
    let bValues: [Float] = [1]
    
    /// Call `nonsymmetric_nonsquare` to compute the _x_ in _Ax = b_.
    let x = nonsymmetric_nonsquare(a: aValues,
                                   dimension: dimension,
                                   b: bValues,
                                   rightHandSideCount: 1)

    /// Prints "[1.4615387, 0.7692307, -1.1766968]".
    print("\n1 x 2 nonsymmetric_nonsquare x =", x ?? [])
}
