#!/bin/sh

#  RunCompleteUnitTestSuite.sh
#  
#
#  Created by Pascal Burlet on 16.03.21.
#  

set -ex
set -o pipefail

arch -arm64 /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild clean test -project PolynomialRegression.xcodeproj -scheme PolynomialRegression -destination "${destination}" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO | xcpretty -r junit
