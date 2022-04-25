#!/bin/sh

#  RunCompleteUnitTestSuite.sh
#  
#
#  Created by Pascal Burlet on 16.03.21.
#  

set -ex
set -o pipefail

#try to build Unit Test Target and fail on failure
echo "Just trying to build"
arch -arm64 swift build

#Run Unit Test but dont fail on failure so that results can be parsed for github
set +ex
set +o pipefail
echo "Running Unit Tests"

arch -arm64 /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -scheme PolynomialRegressionSwift -destination "platform=iOS Simulator,name=iPhone 12" -enableCodeCoverage YES -derivedDataPath "derivedData" clean test | xcpretty -r junit
