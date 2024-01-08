#!/bin/zsh

#  ci_post_xcodebuild.sh
#  dcbattwebhook-swift
#
#  Created by Stella Luna on 1/8/24.
#

if [[ -d "$CI_APP_STORE_SIGNED_APP_PATH" ]]; then
  TESTFLIGHT_DIR_PATH=../TestFlight
  mkdir $TESTFLIGHT_DIR_PATH
  echo "Automatic build - Last three commits:" >! $TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt
  git fetch --deepen 3 && git log -3 --pretty=format:"%h by %an (%as): %s%n" >> $TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt
fi
