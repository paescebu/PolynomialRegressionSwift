#!/bin/sh

#  RunCompleteUnitTestSuite.sh
#  
#
#  Created by Pascal Burlet on 16.03.21.
#  

set -ex
set -o pipefail

#try to build Unit Test Target and fail on failure
cd implementation
echo "Just trying to build"
arch -arm64 /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -project PolynomialRegression.xcodeproj -scheme PolynomialRegression -destination "${destination}" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO | xcpretty

#Run Unit Test but dont fail on failure so that results can be parsed for github
set +ex
set +o pipefail
echo "Running Unit Tests"
arch -arm64 /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild clean test -project PolynomialRegression.xcodeproj -scheme PolynomialRegression -destination "${destination}" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO | xcpretty -r junit
