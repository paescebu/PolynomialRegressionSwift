//
//  PolynomialRegressionTests.swift
//  PolynomialRegressionTests
//
//  Created by Pascal Burlet on 14.03.21.
//  Copyright © 2021 Gilles Lesire. All rights reserved.
//

import XCTest
@testable import PolynomialRegressionSwift

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
        XCTAssertEqual(regression![0], 1.0004208813509532)
        XCTAssertEqual(regression![1], 223.5562565476554)
        XCTAssertEqual(regression![2], -81.13004309269859)
        XCTAssertEqual(regression![3], 11.576395201234615)
        XCTAssertEqual(regression![4], -0.8357768215186393)
        XCTAssertEqual(regression![5], 0.03240311310095307)
        XCTAssertEqual(regression![6], -0.0006438077114256028)
        XCTAssertEqual(regression![7], 5.152994781918991e-06)
    }
    
    func testPolynomial6thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 6)
        XCTAssertEqual(regression![0], 1.0113408375997626)
        XCTAssertEqual(regression![1], -24.00251085070317)
        XCTAssertEqual(regression![2], 4.558007347944319)
        XCTAssertEqual(regression![3], -0.23812712711865547)
        XCTAssertEqual(regression![4], -0.0005106883553711002)
        XCTAssertEqual(regression![5], 0.00030722936386030377)
        XCTAssertEqual(regression![6], -5.4557347736579514e-06)
    }
        
    func testPolynomial5thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points.reversed(), degree: 5)
        XCTAssertEqual(regression![0], 1.0177153322853378)
        XCTAssertEqual(regression![1], -34.97211616147915)
        XCTAssertEqual(regression![2], 7.86988241057499)
        XCTAssertEqual(regression![3], -0.6172297609787191)
        XCTAssertEqual(regression![4], 0.020177058483039342)
        XCTAssertEqual(regression![5], -0.00023390764251986326)
    }
    
    func testPolynomial4thtOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 4)
        XCTAssertEqual(regression![0], 0.5188252635182374)
        XCTAssertEqual(regression![1], -5.004350679975815)
        XCTAssertEqual(regression![2], 0.9467886107646238)
        XCTAssertEqual(regression![3], -0.055798155955976585)
        XCTAssertEqual(regression![4], 0.0010335530900089304)
    }
    
    func testPolynomial3rdOrder() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 3)
        XCTAssertEqual(regression![0], -0.8118189455117972)
        XCTAssertEqual(regression![1], 2.930948568909978)
        XCTAssertEqual(regression![2], -0.33216611492075365)
        XCTAssertEqual(regression![3], 0.008894791307052355)
    }
    
    func testPolynomial2ndOrderQuadratic() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 2)
        XCTAssertEqual(regression![0], 3.9758682949038366)
        XCTAssertEqual(regression![1], -1.4996371619443858)
        XCTAssertEqual(regression![2], 0.06945564017892344)
    }
    
    func testPolynomial1stOrderLinear() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 1)
        XCTAssertEqual(regression![0], -7.708688859512355)
        XCTAssertEqual(regression![1], 0.7330849657493212)
    }
    
    func testPolynomialRegressionFails() {
        var regression = PolynomialRegression.regression(withPoints: points, degree: 0)
        XCTAssertEqual(regression, nil)
        
        regression = PolynomialRegression.regression(withPoints: [], degree: 1)
        XCTAssertEqual(regression, nil)

        regression = PolynomialRegression.regression(withPoints: [CGPoint(x: 0, y: 0)], degree: 1)
        XCTAssertEqual(regression, nil)
    }
	
	func testPolynomialRegressionSumOfSquares(){
		let regression = PolynomialRegression.regression(withPoints: points, degree: 3)
		let sumOfSquare = PolynomialRegression.calculateResidualSumOfSquares(ofPoints: points, withCoefficients: regression!)
		XCTAssertEqual(sumOfSquare!, 551.0158144934717)
	}
	
	func testPolynomialRegressionSumOfSquaresFails(){
		let regression = PolynomialRegression.regression(withPoints: points, degree: 3)
		
		var sumOfSquare = PolynomialRegression.calculateResidualSumOfSquares(ofPoints: [], withCoefficients: regression!)
		XCTAssertEqual(sumOfSquare, nil)

		sumOfSquare = PolynomialRegression.calculateResidualSumOfSquares(ofPoints: points, withCoefficients: [])
		XCTAssertEqual(sumOfSquare, nil)
		
		sumOfSquare = PolynomialRegression.calculateResidualSumOfSquares(ofPoints: [CGPoint(x: 0, y: 0)], withCoefficients: regression!)
		XCTAssertEqual(sumOfSquare, nil)
		
		sumOfSquare = PolynomialRegression.calculateResidualSumOfSquares(ofPoints: [], withCoefficients: [])
		XCTAssertEqual(sumOfSquare, nil)
	}
}
