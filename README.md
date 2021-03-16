# PolynomialRegressionSwift
Swift function for calculation the polynomial regression of a given dataset.

This is a fork of the https://github.com/KingIsulgard/iOS-Polynomial-Regression repository, just converted to Swift.

You have to give an array of CGPoint and the desired order of polynomial you would like to aquire. The function will return an Array containing the polynomial coefficients. 

## Overview
* [Features](#features)
* [Example](#example)
* [Implementation](#implementation)
* [Warranty](#warranty)

## Features
- Can calculate any degree of polynomial
- Easy to implement
- Very compact, one line usage
- Also contains a custom matrix class for this project which handles doubles

## Example

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


    let regression = PolynomialRegression.regression(withPoints: points, degree: 6)
    
    print("The result is the sum of")
    for i in 0..<regression!.count {
        let coefficient = regression![i]
        print("\(coefficient) * x^\(i)");
    }

Generates the following output in console
```
The result is the sum of
1.011300320206601 * x^0
-23.964675682766202 * x^1
4.546635485744847 * x^2
-0.23683080116609886 * x^3
-0.0005811674529158227 * x^4
0.0003090669456971004 * x^5
-5.474209344783135e-06 * x^6
```

## Implementation
Implementation is easy. Just add the classes to your project and import 'PolynomialRegression'.

You're welcome to use it in commercial, closed-source, open source, free or any other kind of software, as long as you credit me appropriately and share any improvements to the code.

## Warranty
The code comes with no warranty of any kind. I hope it'll be useful to you (it certainly is to me), but I make no guarantees regarding its functionality or otherwise.
