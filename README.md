# iOS-Polynomial-Regression
Swift function for calculation the polynomial regression of a given dataset.

This is a fork of the https://github.com/KingIsulgard/iOS-Polynomial-Regression repository, just converted to Swift.

You have to give an array of Double for the x values and y values and the desired order of polynomial you would like to aquire. The function will return an Array containing the polynomial coefficients. 

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

    let xValues:[Double] = [
        0,
        9,
        13,
        15,
        19,
        20,
        26,
        26,
        29,
        30
    ]
    let yValues:[Double] = [
        1,
        -7,
        6,
        12,
        -4,
        -12,
        -2,
        13,
        23,
        30
    ]

    let regression = PolynomialRegression.regression(withXValues: xValues, yValues: yValues, degree: 6)

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
