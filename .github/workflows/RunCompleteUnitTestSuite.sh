#!/bin/sh

#  UnitTestSuite.sh
#  
#
#  Created by Pascal Burlet on 16.03.21.
#  

arch -arm64 /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild clean test -project PolynomialRegression.xcodeproj -scheme PolynomialRegression -destination "${destination}" | /usr/local/bin/xcpretty -r junit
