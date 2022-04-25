#!/bin/sh

#  ExportCodeCoverage.sh
#  
#
#  Created by Pascal Burlet on 16.03.21.
#

echo "Exporting Code Coverage Report"

xcov    -s "PolynomialRegressionSwift"\
        --exclude_targets "PolynomialRegressionSwiftTests"\
        --minimum_coverage_percentage "95.0"\
        -x "./.github/workflows/xcov/.xcovignore"\
        -o "PolynomialRegressionSwift/build/xcov_output/" \
        -j "derivedData" \
        --is_swift_package true
