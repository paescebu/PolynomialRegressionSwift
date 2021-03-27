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

    let epsilon = 1e-09
    
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
        XCTAssertEqual(regression![0], 0.9997187504182656, accuracy: epsilon)
        XCTAssertEqual(regression![1], 230.12719445229567, accuracy: epsilon)
        XCTAssertEqual(regression![2], -83.3903188588482, accuracy: epsilon)
        XCTAssertEqual(regression![3], 11.88582837943588, accuracy: epsilon)
        XCTAssertEqual(regression![4], -0.8574820487381289, accuracy: epsilon)
        XCTAssertEqual(regression![5], 0.033230151861467896, accuracy: epsilon)
        XCTAssertEqual(regression![6], -0.000660111754677297, accuracy: epsilon)
        XCTAssertEqual(regression![7], 5.28341488721737e-06, accuracy: epsilon)
    }
    
    func testPolynomial6thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 6)
        XCTAssertEqual(regression![0], 1.0113003201116135, accuracy: epsilon)
        XCTAssertEqual(regression![1], -23.96467552450793, accuracy: epsilon)
        XCTAssertEqual(regression![2], 4.546635437957598, accuracy: epsilon)
        XCTAssertEqual(regression![3], -0.2368307956952206, accuracy: epsilon)
        XCTAssertEqual(regression![4], -0.0005811677515024719, accuracy: epsilon)
        XCTAssertEqual(regression![5], 0.0003090669535082414, accuracy: epsilon)
        XCTAssertEqual(regression![6], -5.474209423542762e-06, accuracy: epsilon)
    }
    
    func testPolynomial5thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points.reversed(), degree: 5)
        XCTAssertEqual(regression![0], 1.0177157904410796, accuracy: epsilon)
        XCTAssertEqual(regression![1], -34.9721327985627, accuracy: epsilon)
        XCTAssertEqual(regression![2], 7.869886191488484, accuracy: epsilon)
        XCTAssertEqual(regression![3], -0.6172300634148667, accuracy: epsilon)
        XCTAssertEqual(regression![4], 0.020177068674101687, accuracy: epsilon)
        XCTAssertEqual(regression![5], -0.00023390776576689195, accuracy: epsilon)
    }
    
    func testPolynomial4thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 4)
        XCTAssertEqual(regression![0], 0.5188252688713818, accuracy: epsilon)
        XCTAssertEqual(regression![1], -5.004350702260305, accuracy: epsilon)
        XCTAssertEqual(regression![2], 0.9467886142476181, accuracy: epsilon)
        XCTAssertEqual(regression![3], -0.05579815612842958, accuracy: epsilon)
        XCTAssertEqual(regression![4], 0.0010335530927193125, accuracy: epsilon)
    }
    
    func testPolynomial3rdOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 3)
        XCTAssertEqual(regression![0], -0.8118189454821437, accuracy: epsilon)
        XCTAssertEqual(regression![1], 2.9309485689169104, accuracy: epsilon)
        XCTAssertEqual(regression![2], -0.3321661149216887, accuracy: epsilon)
        XCTAssertEqual(regression![3], 0.008894791307075604, accuracy: epsilon)
    }
    
    func testPolynomial2ndOrderQuadratic() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 2)
        XCTAssertEqual(regression![0], 3.975868294910012, accuracy: epsilon)
        XCTAssertEqual(regression![1], -1.4996371619453817, accuracy: epsilon)
        XCTAssertEqual(regression![2], 0.0694556401789527, accuracy: epsilon)
    }
    
    func testPolynomial1stOrderLinear() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 1)
        XCTAssertEqual(regression![0], -7.7086888595120815, accuracy: epsilon)
        XCTAssertEqual(regression![1], 0.7330849657493091, accuracy: epsilon)
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
