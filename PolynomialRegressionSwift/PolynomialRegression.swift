//
//  PolynomialRegression.swift
//  PolynomialRegression
//
//  Created by Pascal Burlet on 14.03.21.
//  Copyright © 2021 Gilles Lesire. All rights reserved.
//

import Foundation
import Accelerate

public class PolynomialRegression {
    public static func regression(withPoints points: [CGPoint], degree: Int) -> [Double]? {
        guard degree > 0 else {
            return nil
        }
        
        guard points.count > 1 else {
            return nil
        }

        let A = createAMatrix(basedOnDegree: degree, columns: degree, withPoints: points)
        let b = createBVector(basedOnDegree: degree, withPoints: points)
        
        var coefficients:[Double] = []
        
        do {
            //solve A x = b
            coefficients = try solveLinearSystem(a: A.asVector,
                                  a_rowCount: A.rows,
                                  a_columnCount: A.columns,
                                  b: b.asVector,
                                  b_count: b.rows)
        } catch {
            fatalError("Unable to solve linear system.")
        }
                
        return coefficients
    }
    
    static func createAMatrix(basedOnDegree degree: Int, columns: Int, withPoints points: [CGPoint]) -> PRMatrix {
        //create A Matrix
        var A = PRMatrix(rows: degree+1, columns: degree+1)
        
        var skip = 0
        for Arow in 0..<A.rows {
            for Acolumn in 0..<A.columns {
                var sum: Double = 0
                for point in points {
                    sum += pow(Double(point.x), Double(skip + Acolumn))
                }
                A[Arow,Acolumn] = sum
            }
            skip+=1
        }
        
        return A
    }
    
    static func createBVector(basedOnDegree degree: Int, withPoints points: [CGPoint]) -> PRMatrix {
        //create b Vector
        var b = PRMatrix(rows: degree+1, columns: 1)
        
        for bRow in 0..<b.rows {
            var sum:Double = 0
            for point in points {
                sum +=  pow(Double(point.x), Double(bRow))  * Double(point.y)
            }
            b[bRow,0] = sum
        }
        return b
    }
    
    //solve A x = b
    static func solveLinearSystem(a: [Double],
                                  a_rowCount: Int, a_columnCount: Int,
                                  b: [Double],
                                  b_count: Int) throws -> [Double] {
        
        let matA = la_matrix_from_double_buffer(a, la_count_t(a_rowCount), la_count_t(a.count/a_rowCount), la_count_t(a_rowCount), la_hint_t(LA_NO_HINT), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
        let vecB = la_matrix_from_double_buffer(b, la_count_t(b_count), 1, 1, la_hint_t(LA_NO_HINT), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
        let vecX = la_solve(matA, vecB)
        var x: [Double] = Array(repeating: 0.0, count: b_count)
        la_matrix_to_double_buffer(&x, 1, vecX)
        
        return x
    }
}
