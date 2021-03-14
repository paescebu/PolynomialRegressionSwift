//
//  DoublesMatrix.swift
//  PolynomialRegression
//
//  Created by Pascal Burlet on 14.03.21.
//  Copyright © 2021 Gilles Lesire. All rights reserved.
//

import Foundation

public struct Matrix<T:Numeric> {
    public var rows: Int
    public var columns: Int
    private (set) var values: [[T]] = []
    
    /**
     * Matrix init
     *
     * Create an empty matrix with zeros of size rowsxcolumns
     */
    internal init(rows m: Int, columns n: Int) {
        self.rows = m
        self.columns = n
        for _ in 0..<m {
            var nValues: [T] = []
            for _ in 0..<n {
                nValues.append(0)
            }
            values.append(nValues)
        }
    }
    
    /**
     * Matrix expand
     *
     * Resize the array to a bigger size if needed
     */
    
    public mutating func expand(toRows m: Int, columns n:Int) {
        if columns < n {
            for i in 0..<rows {
                let adder: Int = n - columns
                for _ in 0..<adder {
                    values[i].append(0)
                }
            }
            columns = n
        }
        if rows < m {
            let adder: Int = m - rows
            for _ in 0..<adder {
                var nValues: [T] = []
                for _ in 0..<n {
                    nValues.append(0)
                }
                values.append(nValues)
            }
            rows = m
        }
    }
    
    /**
     * Matrix setvalue
     *
     * Set the value at a certain row and column
     */
    public mutating func setValue(atRow m: Int, andColumn n: Int, value: T) {
        if m >= rows || n >= columns {
            expand(toRows: m + 1, columns: n + 1)
        }
        values[m][n] = value
    }
    
    /**
     * Matrix getvalue
     *
     * Get the value at a certain row and column
     */
    public mutating func value(atRow m: Int, andColumn n: Int) -> T {
        if m >= rows || n >= columns {
            expand(toRows: m + 1, columns: n + 1)
        }
        return values[m][n]
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
    public mutating func transpose() -> Matrix<T> {
        var transposed = Matrix<T>(rows: columns, columns: rows)
        for i in 0..<rows {
            for j in 0..<columns {
                let matrixValue:T = value(atRow: i, andColumn: j)
                transposed.setValue(atRow: j, andColumn: i, value: matrixValue)
            }
        }
        return transposed
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
    public static func *(left: Matrix<T>, right:Matrix<T>) -> Matrix<T> {
        assert(left.columns == right.rows, "There should be as many columns in matrix A (this matrix) as there are rows in matrix B (parameter matrix) to multiply. Matrix A has %lu columns and matrix B has %lu rows. left matrix colums: \(left.columns), right matrix rows\(right.rows)")
        
        // The result of a mxn matrix multiplied with an nxp matrix resulsts in a mxp matrix
        var result = Matrix<T>(rows: left.rows, columns: right.columns)
        for rCol in 0..<right.columns {
            for lRow in 0..<left.rows {
                var value:T = 0
                for col in 0..<left.columns {
                    value += (left.values[lRow][col] * right.values[col][rCol])
                }
                result.values[lRow][rCol] = value
            }
        }
        return result
    }
    
    /**
     * Matrix rotateLeft
     *
     * Rotate all row elements in the matrix one column to the left
     */
    public mutating func rotateLeft() {
        for m in 0..<rows {
            var row: [T] = values[m]
            let shiftObject: T = row[0]
            row.remove(at: 0)
            row.append(shiftObject)
            values[m] = row //necessary?
        }
    }
    
    /**
     * Matrix rotateRight
     *
     * Rotate all row elements in the matrix one column to the right
     */
    public mutating func rotateRight() {
        for m in 0..<rows {
            var row: [T] = values[m]
            let shiftObject: T = row[columns-1]
            row.remove(at: columns-1)
            row.insert(shiftObject, at: 0)
            values[m] = row //necessary?
        }
    }
    
    /**
     * Matrix rotateTop
     *
     * Rotate all column elements in the matrix one row to the top
     */
    public mutating func rotateTop() {
        let row:[T] = values[0]
        values.remove(at: 0)
        values.append(row)
    }
    
    /**
     * Matrix rotateBottom
     *
     * Rotate all column elements in the matrix one row to the bottom
     */
    public mutating func rotateBottom() {
        let row:[T] = values[rows-1]
        values.remove(at: rows-1)
        values.insert(row, at: 0)
    }
    
    /**
     * Matrix determinant
     *
     * Calculates the determinant value of the matrix
     *
     * Eg.
     * [1,2,3]
     * [4,5,6]
     * calculates
     * 1*5*3 + 2*6*1 + 3*4*2 - 3*5*1 - 2*4*3 - 1*6*2
     * equals 0
     *
     * @link http://en.wikipedia.org/wiki/Determinant Wikipedia
     */
    public mutating func determinant() -> T {
        var det: T = 0

        for i in 0..<rows {
            var product: T = 1
            for j in 0..<columns {
                let column = Int(fmodf(Float(i + j), Float(columns)))
                let row = Int(fmodf(Float(j), Float(rows)))
                product *= value(atRow: row, andColumn: column)
            }
            det += product
            
            product = 1

            for j in 0..<columns {
                let column = Int(fmodf(Float(i - j + columns), Float(columns)))
                let row = Int(fmodf(Float(j), Float(rows)))
                product *= value(atRow: row, andColumn: column)
            }

            det -= product
        }
        return det
    }
}
