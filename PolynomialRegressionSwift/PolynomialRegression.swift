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
    public static func regression(withPoints points: [CGPoint], degree: Int) -> [Float]? {
        guard degree > 0 else {
            return nil
        }
        
        guard points.count > 1 else {
            return nil
        }

        let A = createAMatrix(basedOnDegree: degree, columns: degree, withPoints: points)
        let b = createBVector(basedOnDegree: degree, withPoints: points)
        
        var coefficients:[Float] = []
        
        //solve A x = b
        coefficients = leastSquares_nonsquare(
            a: A.asVector,
            dimension: (A.rows, A.columns),
            b: b.asVector) ?? []
        return coefficients
    }
    
    static func createAMatrix(basedOnDegree degree: Int, columns: Int, withPoints points: [CGPoint]) -> PRMatrix {
        //create A Matrix
        var A = PRMatrix(rows: degree+1, columns: degree+1)
        
        var skip = 0
        for Arow in 0..<A.rows {
            for Acolumn in 0..<A.columns {
                var sum: Float = 0
                for point in points {
                    sum += pow(Float(point.x), Float(skip + Acolumn))
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
            var sum:Float = 0
            for point in points {
                sum +=  pow(Float(point.x), Float(bRow))  * Float(point.y)
            }
            b[bRow,0] = sum
        }
        return b
    }
}
