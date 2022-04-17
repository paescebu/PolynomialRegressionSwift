//
//  PRMatrix.swift
//  PolynomialRegression
//
//  Created by Pascal Burlet on 14.03.21.
//  Copyright © 2021 Gilles Lesire. All rights reserved.
//

import Foundation
import Accelerate


/**
 * Matrix for Double Precision
 */
struct PRMatrix {
    public var rows: Int
    public var columns: Int
    public var asVector: [Double] = []
    
    /**
     * Matrix init
     *
     * Create an empty matrix with zeros of size rowsxcolumns
     */
    internal init(rows m: Int, columns n: Int) {
        self.rows = m
        self.columns = n
        asVector = Array.init(repeating: 0, count: m*n)
    }
    
    /**
     * Matrix expand
     *
     * Resize the array to a bigger size if needed
     */
    
    public mutating func expand(toRows m: Int, columns n:Int) {
        if rows < m {
            asVector.append(contentsOf: Array.init(repeating: 0, count: columns*(m - rows)))
            self.rows = m
        }
        if columns < n {
            for row in (1...rows).reversed() {
                asVector.insert(contentsOf: Array.init(repeating: 0, count: (n-columns)), at: row*columns)
            }
            self.columns = n
        }
    }
    
    public subscript(row m: Int, column n: Int) -> Double {
        get {
            let positionIn1DMatrix = m*columns+n
            return asVector[positionIn1DMatrix]
        }
        set(newValue) {
            let positionIn1DMatrix = m*columns+n
            if positionIn1DMatrix == asVector.count {
                asVector.append(newValue)
            } else {
                asVector[positionIn1DMatrix] = newValue
            }
        }
    }
    
    public subscript(_ m: Int, _ n: Int) -> Double {
        get {
            self[row: m, column: n]
        }
        set(newValue) {
            self[row: m, column: n] = newValue
        }
    }
    
    public func printMatrix() {
        for row in 0..<self.rows {
            var rowString: String = ""
            for column in 0..<columns {
                rowString.append(" \(self[row,column])")
            }
            print(rowString)
        }
    }
    
    /**
     * Matrix transpose
     * Result is a new matrix created by transposing this current matrix
     *
     * Eg.
     * [1,2,3]
     * [4,5,6]
     * becomes
     * [1,4]
     * [2,5]
     * [3,6]
     *
     * @link http://en.wikipedia.org/wiki/Transpose Wikipedia
     */
    public mutating func transpose() -> PRMatrix {
        var result = PRMatrix(rows: self.columns, columns: self.rows)
        var C = result.asVector
        let aStride = vDSP_Stride(1)
        let cStride = vDSP_Stride(1)
        let mLength = vDSP_Length(rows)
        let nLength = vDSP_Length(columns)
        vDSP_mtransD(self.asVector, aStride, &C, cStride, nLength, mLength)
        result.asVector = C
        return result
    }
    
    /**
     * Matrix multiply
     * Result is a new matrix created by multiplying this current matrix with a given matrix
     * The current matrix A should have just as many columns as the given matrix B has rows
     * otherwise multiplication is not possible
     *
     * The result of a mxn matrix multiplied with an nxp matrix resulsts in a mxp matrix
     * (AB)_{ij} = \sum_{r=1}^n a_{ir}b_{rj} = a_{i1}b_{1j} + a_{i2}b_{2j} + \cdots + a_{in}b_{nj}.
     *
     * @link http://en.wikipedia.org/wiki/Matrix_multiplication Wikipedia
     */
    public static func *(left: PRMatrix, right: PRMatrix) -> PRMatrix {
        assert(left.columns == right.rows, "There should be as many columns in matrix A (this matrix) as there are rows in matrix B (parameter matrix) to multiply. Matrix A has %lu columns and matrix B has %lu rows. left matrix colums: \(left.columns), right matrix rows\(right.rows)")
        
        let A = left.asVector
        let B = right.asVector
        var result = PRMatrix(rows: left.rows, columns: right.columns)
        var C = result.asVector
        
        let aStride = vDSP_Stride(1)
        let bStride = vDSP_Stride(1)
        let cStride = vDSP_Stride(1)

        vDSP_mmulD(
            A, aStride,
            B, bStride,
            &C, cStride,
            vDSP_Length(left.rows),
            vDSP_Length(result.columns),
            vDSP_Length(right.rows)
        )
        result.asVector = C
        return result
    }
}
