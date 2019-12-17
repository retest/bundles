#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

BUCKET='DO:retest'

## Linux stuff
if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    echo "Deploying Linux bundles ..."
    rclone copy ${TRAVIS_BUILD_DIR}/packages/review_1.0.0-1_amd64.deb ${BUCKET}/releases/review/bundles/${TRAVIS_BUILD_NUMBER}
fi

## OSX stuff
if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    echo "Deploying Mac bundles ..."
    rclone copy ${TRAVIS_BUILD_DIR}/packages/review.zip ${BUCKET}/releases/review/bundles/${TRAVIS_BUILD_NUMBER}
    find ${TRAVIS_BUILD_DIR}/packages
fi

## Windows stuff
if [[ $TRAVIS_OS_NAME == 'windows' ]]; then
    echo "Deploying Windows bundles ..."
fi
