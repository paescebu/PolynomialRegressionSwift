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
    
    let points:[CGPoint] = [
        CGPoint(x: 0, y: 1),
        CGPoint(x: 9, y: -7),
        CGPoint(x: 13, y: 6),
        CGPoint(x: 15, y: 12),
        CGPoint(x: 19, y: -4),
        CGPoint(x: 20, y: -12),
        CGPoint(x: 26, y: -2),
        CGPoint(x: 26, y: 13),
        CGPoint(x: 29, y: 23),
        CGPoint(x: 30, y: 30),
    ]
    
    func testPolynomial7thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points.reversed(), degree: 7)
        XCTAssertEqual(regression![0], -55.11116)
        XCTAssertEqual(regression![1], 0.39892817)
        XCTAssertEqual(regression![2], 0.09908019)
        XCTAssertEqual(regression![3], -0.00015769922)
        XCTAssertEqual(regression![4], -5.7026587e-05)
        XCTAssertEqual(regression![5], 1.340941e-06)
        XCTAssertEqual(regression![6], 0.0)
        XCTAssertEqual(regression![7], 0.0)
    }
    
    func testPolynomial6thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 6)
        XCTAssertEqual(regression![0], -93.48439)
        XCTAssertEqual(regression![1], -9.618948)
        XCTAssertEqual(regression![2], 0.7369675)
        XCTAssertEqual(regression![3], -0.002899922)
        XCTAssertEqual(regression![4], 0.00041981816)
        XCTAssertEqual(regression![5], -1.729087e-05)
        XCTAssertEqual(regression![6], -1.6198597e-07)
    }
    
    func testPolynomial5thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points.reversed(), degree: 5)
        XCTAssertEqual(regression![0], -27.465906)
        XCTAssertEqual(regression![1], 1.1991093)
        XCTAssertEqual(regression![2], 0.0039667077)
        XCTAssertEqual(regression![3], -0.0015832959)
        XCTAssertEqual(regression![4], 5.7597055e-05)
        XCTAssertEqual(regression![5], 4.390755e-07)
    }
    
    func testPolynomial4thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 4)
        XCTAssertEqual(regression![0], -0.89058954)
        XCTAssertEqual(regression![1], -0.36468905)
        XCTAssertEqual(regression![2], -0.0107366145)
        XCTAssertEqual(regression![3], 0.0001396488)
        XCTAssertEqual(regression![4], 5.436629e-05)
    }
    
    func testPolynomial3rdOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 3)
        XCTAssertEqual(regression![0], -27.539585)
        XCTAssertEqual(regression![1], 1.2988589)
        XCTAssertEqual(regression![2], 0.0089864135)
        XCTAssertEqual(regression![3], 6.342103e-05)
    }
    
    func testPolynomial2ndOrderQuadratic() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 2)
        XCTAssertEqual(regression![0], -35.72668)
        XCTAssertEqual(regression![1], 2.7211537)
        XCTAssertEqual(regression![2], -0.031249998)
    }
    
    func testPolynomial1stOrderLinear() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 1)
        XCTAssertEqual(regression![0], -7.6960907)
        XCTAssertEqual(regression![1], 0.7325405)
    }
    
    func testPolynomialRegressionFails() {
        var regression = PolynomialRegression.regression(withPoints: points, degree: 0)
        XCTAssertEqual(regression, nil)
        
        regression = PolynomialRegression.regression(withPoints: [], degree: 1)
        XCTAssertEqual(regression, nil)
        
        regression = PolynomialRegression.regression(withPoints: [CGPoint(x: 0, y: 0)], degree: 1)
        XCTAssertEqual(regression, nil)
    }
}
