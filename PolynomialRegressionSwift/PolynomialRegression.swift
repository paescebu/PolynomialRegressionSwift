//
//  PolynomialRegression.swift
//  PolynomialRegression
//
//  Created by Pascal Burlet on 14.03.21.
//  Copyright © 2021 Gilles Lesire. All rights reserved.
//

import Foundation


public class PolynomialRegression {
    public static func regression(withPoints points: [CGPoint], degree: Int) -> [Double]? {
        guard degree > 0 else {
            return nil
        }
        
        guard points.count > 1 else {
            return nil
        }

        var z = Matrix<Double>(rows: points.count, columns: degree+1)
        
        for i in 0..<points.count {
            for j in 0...degree {
                let val = pow(Double(points[i].x), Double(j))
                z.setValue(atRow: i, andColumn: j, value: val)
            }
        }
        
        var y = Matrix<Double>(rows: points.count, columns: 1)

        for u in 0..<points.count {
            y.setValue(atRow: u, andColumn: 0, value: Double(points[u].y))
        }

        let zTransposed = z.transpose()
        let l = zTransposed * z
        let r = zTransposed * y

        var regression = solve(forleftMatrix: l, andrightMatrix: r)
        var result: [Double] = []
        
        for i in 0...degree {
            if let value = regression?.value(atRow: i, andColumn: 0) {
                result.append(value)
            }
        }

        return result
    }
    
    private static func solve(forleftMatrix: Matrix<Double>, andrightMatrix: Matrix<Double>) -> Matrix<Double>? {
        let l = forleftMatrix
        var r = andrightMatrix
        var resultMatrix = Matrix<Double>(rows: l.rows, columns: 1)

        let resDecomp = self.decompose(l: l)

        var nP = resDecomp[2]
        var lMatrix = resDecomp[1]
        var uMatrix = resDecomp[0]

        for k in 0..<(r.rows) {
            var sum = 0.0

            var dMatrix = Matrix<Double>(rows: l.rows, columns: 1)

            let val1 = r.value(atRow: Int(nP.value(atRow: 0, andColumn: 0)), andColumn: k)
            let val2 = lMatrix.value(atRow: 0, andColumn: 0)
            dMatrix.setValue(atRow: 0, andColumn: 0, value: val1 / val2)

            for i in 1..<(l.rows) {
                sum = 0.0
                for j in 0..<i {
                    sum += lMatrix.value(atRow: i, andColumn: j) * dMatrix.value(atRow: j, andColumn: 0)
                }

                var value = r.value(atRow: Int(nP.value(atRow: i, andColumn: 0)), andColumn: k)
                value -= sum
                value /= lMatrix.value(atRow: i, andColumn: i)
                dMatrix.setValue(atRow: i, andColumn: 0, value: value)
            }

            resultMatrix.setValue(atRow: ((l.rows) - 1), andColumn: k, value: dMatrix.value(atRow: ((l.rows) - 1), andColumn: 0))

            var i = ((l.rows) - 2)
            while i >= 0 {
                sum = 0.0
                for j in (i + 1)..<(l.rows) {
                    sum += uMatrix.value(atRow: i, andColumn: j) * resultMatrix.value(atRow: j, andColumn: k)
                }
                resultMatrix.setValue(atRow: i, andColumn: k, value: (dMatrix.value(atRow: i, andColumn: 0) - sum))
                i -= 1
            }
        }

        return resultMatrix
    }
    
    private static func decompose(l: Matrix<Double>) -> [Matrix<Double>] {
        var uMatrix = Matrix<Double>(rows: 1, columns: 1)
        var lMatrix = Matrix<Double>(rows: 1, columns: 1)
        var workingUMatrix = l
        var workingLMatrix = Matrix<Double>(rows: 1, columns: 1)

        var pivotArray = Matrix<Double>(rows: l.rows, columns: 1)

        for i in 0..<l.rows {
            pivotArray.setValue(atRow: i, andColumn: 0, value: Double(i))
        }
        
        for i in 0..<l.rows {
            var maxRowRatio: Double = -2147483648
            var maxRow = -1
            var maxPosition = -1

            for j in i..<l.rows {
                var rowSum = 0.0

                for k in i..<l.rows {
                    rowSum += Double(abs(workingUMatrix.value(atRow: Int(pivotArray.value(atRow: j, andColumn: 0)), andColumn: k)))
                }

                let dCurrentRatio = Double(abs(workingUMatrix.value(atRow: Int(pivotArray.value(atRow: j, andColumn: 0)), andColumn: i))) / rowSum

                if dCurrentRatio > maxRowRatio {
                    maxRowRatio = Double(Int(abs(workingUMatrix.value(atRow: Int(pivotArray.value(atRow: j, andColumn: 0)), andColumn: i)))) / rowSum
                    maxRow = Int(pivotArray.value(atRow: j, andColumn: 0))
                    maxPosition = j
                }
            }

            if maxRow != Int(pivotArray.value(atRow: i, andColumn: 0)) {
                let hold = pivotArray.value(atRow: i, andColumn: 0)
                pivotArray.setValue(atRow: i, andColumn: 0, value: Double(maxRow))
                pivotArray.setValue(atRow: maxPosition, andColumn: 0, value: hold)
            }

            var rowFirstElementValue = workingUMatrix.value(atRow: Int(pivotArray.value(atRow: i, andColumn: 0)), andColumn: i)

            for j in 0..<l.rows {
                if j < i {
                    workingUMatrix.setValue(atRow: Int(pivotArray.value(atRow: i, andColumn: 0)), andColumn: j, value: 0.0)
                } else if j == i {
                    workingLMatrix.setValue(atRow: Int(pivotArray.value(atRow: i, andColumn: 0)), andColumn: j, value: rowFirstElementValue)
                    workingUMatrix.setValue(atRow: Int(pivotArray.value(atRow: i, andColumn: 0)), andColumn: j, value: 1.0)
                } else {
                    let tempValue = workingUMatrix.value(atRow: Int(pivotArray.value(atRow: i, andColumn: 0)), andColumn: j)
                    workingUMatrix.setValue(atRow: Int(pivotArray.value(atRow: i, andColumn: 0)), andColumn: j, value: tempValue / rowFirstElementValue)
                    workingLMatrix.setValue(atRow: Int(pivotArray.value(atRow: i, andColumn: 0)), andColumn: j, value: 0.0)
                }
            }
            
            for k in (i + 1)..<l.rows {
                rowFirstElementValue = workingUMatrix.value(atRow: Int(pivotArray.value(atRow: k, andColumn: 0)), andColumn: i)
                for j in 0..<l.rows {
                    if j < i {
                        workingUMatrix.setValue(atRow: Int(pivotArray.value(atRow: k, andColumn: 0)), andColumn: j, value: 0.0)
                    } else if j == i {
                        workingLMatrix.setValue(atRow: Int(pivotArray.value(atRow: k, andColumn: 0)), andColumn: j, value: rowFirstElementValue)
                        workingUMatrix.setValue(atRow: Int(pivotArray.value(atRow: k, andColumn: 0)), andColumn: j, value: 0.0)
                    } else {
                        let tempValue = workingUMatrix.value(atRow: Int(pivotArray.value(atRow: k, andColumn: 0)), andColumn: j)
                        let tempValue2 = workingUMatrix.value(atRow: Int(pivotArray.value(atRow: i, andColumn: 0)), andColumn: j)
                        workingUMatrix.setValue(atRow: Int(pivotArray.value(atRow: k, andColumn: 0)), andColumn: j, value: tempValue - (rowFirstElementValue * tempValue2))
                    }
                }
            }
        }
        
        for i in 0..<l.rows {
            for j in 0..<l.rows {
                let uValue = workingUMatrix.value(atRow: Int(pivotArray.value(atRow: i, andColumn: 0)), andColumn: j)
                let lValue = workingLMatrix.value(atRow: Int(pivotArray.value(atRow: i, andColumn: 0)), andColumn: j)
                uMatrix.setValue(atRow: i, andColumn: j, value: uValue)
                lMatrix.setValue(atRow: i, andColumn: j, value: lValue)
            }
        }

        var result: [Matrix<Double>] = []
        result.append(uMatrix)
        result.append(lMatrix)
        result.append(pivotArray)

        return result
    }
}
