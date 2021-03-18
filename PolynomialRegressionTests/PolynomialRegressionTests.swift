//
//  PolynomialRegressionTests.swift
//  PolynomialRegressionTests
//
//  Created by Pascal Burlet on 14.03.21.
//  Copyright © 2021 Gilles Lesire. All rights reserved.
//

import XCTest
@testable import PolynomialRegression

class PolynomialRegressionTests: XCTestCase {

    let points:[(x:Double,y:Double)] = [
        (x: 0, y: 1),
        (x: 9, y: -7),
        (x: 13, y: 6),
        (x: 15, y: 12),
        (x: 19, y: -4),
        (x: 20, y: -12),
        (x: 26, y: -2),
        (x: 26, y: 13),
        (x: 29, y: 23),
        (x: 30, y: 30),
    ]
    
    func testPolynomial6thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 6)
        XCTAssertEqual(regression![0], 1.011300320206601)
        XCTAssertEqual(regression![1], -23.964675682766202)
        XCTAssertEqual(regression![2], 4.546635485744847)
        XCTAssertEqual(regression![3], -0.23683080116609886)
        XCTAssertEqual(regression![4], -0.0005811674529158227)
        XCTAssertEqual(regression![5], 0.0003090669456971004)
        XCTAssertEqual(regression![6], -5.474209344783135e-06)
    }

    
    func testPolynomial5thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 5)
        XCTAssertEqual(regression![0], 1.0177157900097882)
        XCTAssertEqual(regression![1], -34.97213277818397)
        XCTAssertEqual(regression![2], 7.869886186817316)
        XCTAssertEqual(regression![3], -0.6172300630385494)
        XCTAssertEqual(regression![4], 0.020177068661343254)
        XCTAssertEqual(regression![5], -0.00023390776561177477)
    }
    
    func testPolynomial4thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 4)
        XCTAssertEqual(regression![0], 0.5188252688664079)
        XCTAssertEqual(regression![1], -5.00435070223329)
        XCTAssertEqual(regression![2], 0.9467886142433064)
        XCTAssertEqual(regression![3], -0.05579815612821298)
        XCTAssertEqual(regression![4], 0.00103355309271587)
    }
    
    func testPolynomial3rdOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 3)
        XCTAssertEqual(regression![0], -0.8118189454820595)
        XCTAssertEqual(regression![1], 2.9309485689169064)
        XCTAssertEqual(regression![2], -0.33216611492168935)
        XCTAssertEqual(regression![3], 0.00889479130707563)
    }
    
    func testPolynomial2ndOrderQuadratic() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 2)
        XCTAssertEqual(regression![0], 3.975868294909997)
        XCTAssertEqual(regression![1], -1.499637161945378)
        XCTAssertEqual(regression![2], 0.06945564017895259)
    }
    
    func testPolynomial1stOrderLinear() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 1)
        XCTAssertEqual(regression![0], -7.708688859512078)
        XCTAssertEqual(regression![1], 0.733084965749309)
    }
    
    func testPolynomialRegressionFails() {
        var regression = PolynomialRegression.regression(withPoints: points, degree: 0)
        XCTAssertEqual(regression, nil)
        
        regression = PolynomialRegression.regression(withPoints: [], degree: 1)
        XCTAssertEqual(regression, nil)

        regression = PolynomialRegression.regression(withPoints: [(x: 0, y: 0)], degree: 1)
        XCTAssertEqual(regression, nil)
    }
}
