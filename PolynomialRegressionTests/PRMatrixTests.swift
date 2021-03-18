//
//  PRMatrixTests.swift
//  PolynomialRegressionTests
//
//  Created by Pascal Burlet on 18.03.21.
//  Copyright © 2021 Gilles Lesire. All rights reserved.
//

import XCTest
@testable import PolynomialRegression

class PRMatrixTests: XCTestCase {
    public func testExpansion() {
        // 1 2
        // 3 4
        var matrix = PRMatrix(rows: 2, columns: 2)
        matrix.setValue(atRow: 0, andColumn: 0, value: 1)
        matrix.setValue(atRow: 0, andColumn: 1, value: 2)
        matrix.setValue(atRow: 1, andColumn: 0, value: 3)
        matrix.setValue(atRow: 1, andColumn: 1, value: 4)
        
        //expand by one per row and column
        // 1 2 0
        // 3 4 0
        // 0 0 0
        matrix.expand(toRows: 3, columns: 3)
        XCTAssertEqual(matrix.singleDimMatrix, [1.0, 2.0, 0.0, 3.0, 4.0, 0.0, 0.0, 0.0, 0.0])
        
        //expand by two per row and column
        // 1 2 0 0 0
        // 3 4 0 0 0
        // 0 0 0 0 0
        // 0 0 0 0 0
        // 0 0 0 0 0
        matrix.expand(toRows: 5, columns: 5)
        XCTAssertEqual(matrix.singleDimMatrix, [1.0, 2.0, 0.0, 0.0, 0.0, 3.0, 4.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])
    }
    
    public func testTranspose() {
        // 1 2
        // 3 4
        // 5 6
        var matrix = PRMatrix(rows: 3, columns: 2)
        matrix.setValue(atRow: 0, andColumn: 0, value: 1)
        matrix.setValue(atRow: 0, andColumn: 1, value: 2)
        matrix.setValue(atRow: 1, andColumn: 0, value: 3)
        matrix.setValue(atRow: 1, andColumn: 1, value: 4)
        matrix.setValue(atRow: 2, andColumn: 0, value: 5)
        matrix.setValue(atRow: 2, andColumn: 1, value: 6)

        matrix = matrix.transpose()
                
        // 1 3 5
        // 2 4 6
        XCTAssertEqual(matrix.rows, 2)
        XCTAssertEqual(matrix.columns, 3)
        XCTAssertEqual(matrix.singleDimMatrix, [1.0, 3.0, 5.0, 2.0, 4.0, 6.0])
    }
    
    public func testInitMatrix() {
        // 1 2
        // 3 4
        // 5 6
        var matrix = PRMatrix(rows: 3, columns: 2)
        matrix.setValue(atRow: 0, andColumn: 0, value: 1)
        matrix.setValue(atRow: 0, andColumn: 1, value: 2)
        matrix.setValue(atRow: 1, andColumn: 0, value: 3)
        matrix.setValue(atRow: 1, andColumn: 1, value: 4)
        matrix.setValue(atRow: 2, andColumn: 0, value: 5)
        matrix.setValue(atRow: 2, andColumn: 1, value: 6)
        
        XCTAssertEqual(matrix.singleDimMatrix, [1.0, 2.0, 3.0, 4.0, 5.0, 6.0])
    }
    
    public func testMatrixMultiplication() {
        // 1 2
        // 3 4
        // 5 6
        var A = PRMatrix(rows: 3, columns: 2)
        A.setValue(atRow: 0, andColumn: 0, value: 1)
        A.setValue(atRow: 0, andColumn: 1, value: 2)
        A.setValue(atRow: 1, andColumn: 0, value: 3)
        A.setValue(atRow: 1, andColumn: 1, value: 4)
        A.setValue(atRow: 2, andColumn: 0, value: 5)
        A.setValue(atRow: 2, andColumn: 1, value: 6)
        
        // 5 3 2 6
        // 2 7 3 6
        var B = PRMatrix(rows: 2, columns: 4)
        B.setValue(atRow: 0, andColumn: 0, value: 5)
        B.setValue(atRow: 0, andColumn: 1, value: 3)
        B.setValue(atRow: 0, andColumn: 2, value: 2)
        B.setValue(atRow: 0, andColumn: 3, value: 6)
        B.setValue(atRow: 1, andColumn: 0, value: 2)
        B.setValue(atRow: 1, andColumn: 1, value: 7)
        B.setValue(atRow: 1, andColumn: 2, value: 3)
        B.setValue(atRow: 1, andColumn: 3, value: 6)
        
        let C = A * B
        //  9 17  8 18
        // 23 37 18 42
        // 37 57 28 66
        XCTAssertEqual(C.rows, 3)
        XCTAssertEqual(C.columns, 4)
        XCTAssertEqual(C.singleDimMatrix, [9.0, 17.0, 8.0, 18.0, 23.0, 37.0, 18.0, 42.0, 37.0, 57.0, 28.0, 66.0])
    }
}
