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

        var z = PRMatrix(rows: points.count, columns: degree+1)
        
        for i in 0..<points.count {
            for j in 0...degree {
                let val = pow(Double(points[i].x), Double(j))
                z.setValue(atRow: i, andColumn: j, value: val, expandIfOutsideMatrix: true)
            }
        }
        
        var y = PRMatrix(rows: points.count, columns: 1)

        for u in 0..<points.count {
            y.setValue(atRow: u, andColumn: 0, value: Double(points[u].y), expandIfOutsideMatrix: true)
        }

        let zTransposed = z.transpose()
        let l = zTransposed * z
        let r = zTransposed * y

        let regression = solve(forleftMatrix: l, andrightMatrix: r)
        var result: [Double] = []
        
        for i in 0...degree {
            if let value = regression?[i, 0] {
                result.append(value)
            }
        }

        return result
    }
    
    private static func solve(forleftMatrix: PRMatrix, andrightMatrix: PRMatrix) -> PRMatrix? {
        let l = forleftMatrix
        var r = andrightMatrix
        var resultMatrix = PRMatrix(rows: l.rows, columns: 1)

        let resDecomp = self.decompose(l: l)

        let nP = resDecomp[2]
        let lMatrix = resDecomp[1]
        let uMatrix = resDecomp[0]

        for k in 0..<(r.rows) {
            var sum = 0.0

            var dMatrix = PRMatrix(rows: l.rows, columns: 1)

            let val1 = r[Int(nP[0,0]), k]
            let val2 = lMatrix[0, 0]
            dMatrix[0, 0] = val1 / val2

            for i in 1..<(l.rows) {
                sum = 0.0
                for j in 0..<i {
                    sum += lMatrix[i, j] * dMatrix[j, 0]
                }

                var value = r.value(atRow: Int(nP[i, 0]), andColumn: k, expandIfOutsideMatrix: true)
                value -= sum
                value /= lMatrix[i, i]
                dMatrix[i, 0] = value
            }

            resultMatrix[l.rows - 1, k] = dMatrix[l.rows - 1, 0]

            var i = ((l.rows) - 2)
            while i >= 0 {
                sum = 0.0
                for j in (i + 1)..<(l.rows) {
                    sum += uMatrix[i, j] * resultMatrix[j, k]
                }
                let value = (dMatrix[i, 0] - sum)
                resultMatrix.setValue(atRow: i, andColumn: k, value: value, expandIfOutsideMatrix: true)
                i -= 1
            }
        }

        return resultMatrix
    }
    
    private static func decompose(l: PRMatrix) -> [PRMatrix] {
        var uMatrix = PRMatrix(rows: 1, columns: 1)
        var lMatrix = PRMatrix(rows: 1, columns: 1)
        var workingUMatrix = l
        var workingLMatrix = PRMatrix(rows: 1, columns: 1)

        var pivotArray = PRMatrix(rows: l.rows, columns: 1)

        for i in 0..<l.rows {
            pivotArray[i, 0] = Double(i)
        }
        
        for i in 0..<l.rows {
            var maxRowRatio: Double = -2147483648
            var maxRow = -1
            var maxPosition = -1
            let firstValueInRow = Int(pivotArray[i, 0])

            for j in i..<l.rows {
                var rowSum = 0.0

                for k in i..<l.rows {
                    let row = Int(pivotArray[j, 0])
                    rowSum += Double(abs(workingUMatrix[row, k]))
                }

                let row = Int(pivotArray[j, 0])
                let dCurrentRatio = Double(abs(workingUMatrix[row, i])) / rowSum
                if dCurrentRatio > maxRowRatio {
                    maxRowRatio = abs(workingUMatrix[row, i]) / rowSum
                    maxRow = Int(pivotArray[j, 0])
                    maxPosition = j
                }
            }

            if maxRow != firstValueInRow {
                let hold = firstValueInRow
                pivotArray[i, 0] = Double(maxRow)
                pivotArray[maxPosition, 0] = Double(hold)
            }

            var rowFirstElementValue = workingUMatrix[firstValueInRow, i]

            for j in 0..<l.rows {
                if j < i {
                    workingUMatrix[firstValueInRow, j] = 0.0
                } else if j == i {
                    workingLMatrix[firstValueInRow, j] = rowFirstElementValue
                    workingUMatrix[firstValueInRow, j] = 1.0
                } else {
                    let tempValue = workingUMatrix[firstValueInRow, j]
                    workingUMatrix[firstValueInRow, j] = tempValue / rowFirstElementValue
                    workingLMatrix.setValue(atRow: firstValueInRow, andColumn: j, value: 0.0, expandIfOutsideMatrix: true)
                }
            }
            
            for k in (i + 1)..<l.rows {
                let firstValueInRow = Int(pivotArray[k, 0])
                rowFirstElementValue = workingUMatrix.value(atRow: firstValueInRow, andColumn: i)
                for j in 0..<l.rows {
                    if j < i {
                        workingUMatrix.setValue(atRow: firstValueInRow, andColumn: j, value: 0.0)
                    } else if j == i {
                        workingLMatrix.setValue(atRow: firstValueInRow, andColumn: j, value: rowFirstElementValue)
                        workingUMatrix.setValue(atRow: firstValueInRow, andColumn: j, value: 0.0)
                    } else {
                        let tempValue = workingUMatrix[firstValueInRow, j]
                        let tempValue2 = workingUMatrix[Int(pivotArray[i, 0]), j]
                        workingUMatrix[firstValueInRow, j] = tempValue - rowFirstElementValue * tempValue2
                    }
                }
            }
        }
        
        for i in 0..<l.rows {
            for j in 0..<l.rows {
                let firstValueInRow = Int(pivotArray[i, 0])
                let uValue = workingUMatrix[firstValueInRow, j]
                let lValue = workingLMatrix[firstValueInRow, j]
                uMatrix.setValue(atRow: i, andColumn: j, value: uValue, expandIfOutsideMatrix: true)
                lMatrix.setValue(atRow: i, andColumn: j, value: lValue, expandIfOutsideMatrix: true)
            }
        }

        var result: [PRMatrix] = []
        result.append(uMatrix)
        result.append(lMatrix)
        result.append(pivotArray)

        return result
    }
}
