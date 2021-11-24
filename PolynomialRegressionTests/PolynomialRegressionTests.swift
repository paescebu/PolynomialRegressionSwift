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
        XCTAssertEqual(regression![0], 0.9997189046459233)
        XCTAssertEqual(regression![1], 230.12481797440154)
        XCTAssertEqual(regression![2], -83.38949881046904)
        XCTAssertEqual(regression![3], 11.885715711723307)
        XCTAssertEqual(regression![4], -0.8574741145000578)
        XCTAssertEqual(regression![5], 0.03322984826496963)
        XCTAssertEqual(regression![6], -0.0006601057431599122)
        XCTAssertEqual(regression![7], 5.2833665805830835e-06)
    }
    
    func testPolynomial6thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 6)
        XCTAssertEqual(regression![0], 1.0113003199370478)
        XCTAssertEqual(regression![1], -23.964675410857108)
        XCTAssertEqual(regression![2], 4.5466354040252215)
        XCTAssertEqual(regression![3], -0.23683079185160397)
        XCTAssertEqual(regression![4], -0.0005811679592643759)
        XCTAssertEqual(regression![5], 0.000309066958897263)
        XCTAssertEqual(regression![6], -5.4742094774774475e-06)
    }
        
    func testPolynomial5thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points.reversed(), degree: 5)
        XCTAssertEqual(regression![0], 1.0177157898324047)
        XCTAssertEqual(regression![1], -34.9721327729066)
        XCTAssertEqual(regression![2], 7.869886185624882)
        XCTAssertEqual(regression![3], -0.6172300629436025)
        XCTAssertEqual(regression![4], 0.020177068658156244)
        XCTAssertEqual(regression![5], -0.00023390776557336056)
    }
    
    func testPolynomial4thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 4)
        XCTAssertEqual(regression![0], 0.5188252688603783)
        XCTAssertEqual(regression![1], -5.004350702209355)
        XCTAssertEqual(regression![2], 0.9467886142395627)
        XCTAssertEqual(regression![3], -0.05579815612802747)
        XCTAssertEqual(regression![4], 0.0010335530927129528)
    }
    
    func testPolynomial3rdOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 3)
        XCTAssertEqual(regression![0], -0.8118189454820346)
        XCTAssertEqual(regression![1], 2.9309485689168353)
        XCTAssertEqual(regression![2], -0.3321661149216823)
        XCTAssertEqual(regression![3], 0.008894791307075467)
    }
    
    func testPolynomial2ndOrderQuadratic() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 2)
        XCTAssertEqual(regression![0], 3.9758682949099846)
        XCTAssertEqual(regression![1], -1.4996371619453779)
        XCTAssertEqual(regression![2], 0.0694556401789526)
    }
    
    func testPolynomial1stOrderLinear() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 1)
        XCTAssertEqual(regression![0], -7.7086888595120815)
        XCTAssertEqual(regression![1], 0.7330849657493091)
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
