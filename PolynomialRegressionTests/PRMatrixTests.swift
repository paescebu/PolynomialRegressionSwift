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
        matrix[0,0] = 1
        matrix[0,1] = 2
        matrix[1,0] = 3
        matrix[1,1] = 4
        
        //expand by one per row and column
        // 1 2 0
        // 3 4 0
        // 0 0 0
        matrix.expand(toRows: 3, columns: 3)
        XCTAssertEqual(matrix.asVector, [1.0, 2.0, 0.0, 3.0, 4.0, 0.0, 0.0, 0.0, 0.0])
        
        //expand by two per row and column
        // 1 2 0 0 0
        // 3 4 0 0 0
        // 0 0 0 0 0
        // 0 0 0 0 0
        // 0 0 0 0 0
        matrix.expand(toRows: 5, columns: 5)
        XCTAssertEqual(matrix.asVector, [1.0, 2.0, 0.0, 0.0, 0.0, 3.0, 4.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])
    }
    
    public func testTranspose() {
        // 1 2
        // 3 4
        // 5 6
        var matrix = PRMatrix(rows: 3, columns: 2)
        matrix[0,0] = 1
        matrix[0,1] = 2
        matrix[1,0] = 3
        matrix[1,1] = 4
        matrix[2,0] = 5
        matrix[2,1] = 6

        matrix = matrix.transpose()
                
        // 1 3 5
        // 2 4 6
        XCTAssertEqual(matrix.rows, 2)
        XCTAssertEqual(matrix.columns, 3)
        XCTAssertEqual(matrix.asVector, [1.0, 3.0, 5.0, 2.0, 4.0, 6.0])
    }
    
    public func testInitMatrix() {
        // 1 2
        // 3 4
        // 5 6
        var matrix = PRMatrix(rows: 3, columns: 2)
        matrix[0,0] = 1
        matrix[0,1] = 2
        matrix[1,0] = 3
        matrix[1,1] = 4
        matrix[2,0] = 5
        matrix[2,1] = 6
        
        XCTAssertEqual(matrix.asVector, [1.0, 2.0, 3.0, 4.0, 5.0, 6.0])
    }
    
    public func testMatrixMultiplication() {
        // 1 2
        // 3 4
        // 5 6
        var A = PRMatrix(rows: 3, columns: 2)
        A[0,0] = 1
        A[0,1] = 2
        A[1,0] = 3
        A[1,1] = 4
        A[2,0] = 5
        A[2,1] = 6
        
        // 5 3 2 6
        // 2 7 3 6
        var B = PRMatrix(rows: 2, columns: 4)
        B[0,0] = 5
        B[0,1] = 3
        B[0,2] = 2
        B[0,3] = 6
        B[1,0] = 2
        B[1,1] = 7
        B[1,2] = 3
        B[1,3] = 6
        
        let C = A * B
        //  9 17  8 18
        // 23 37 18 42
        // 37 57 28 66
        XCTAssertEqual(C.rows, 3)
        XCTAssertEqual(C.columns, 4)
        XCTAssertEqual(C.asVector, [9.0, 17.0, 8.0, 18.0, 23.0, 37.0, 18.0, 42.0, 37.0, 57.0, 28.0, 66.0])
    }
}
