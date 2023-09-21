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
swift build

#Run Unit Test but dont fail on failure so that results can be parsed for github
set +ex
set +o pipefail
echo "Running Unit Tests"

xcodebuild -scheme PolynomialRegressionSwift -destination "platform=iOS Simulator,name=iPhone 12" -enableCodeCoverage YES -derivedDataPath "derivedData" clean test | xcpretty -r junit
