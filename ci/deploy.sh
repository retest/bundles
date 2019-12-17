#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

BUCKET='DO:retest'

## Linux stuff
if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    echo "Deploying Linux bundles ..."

    # rclone copy ${SOURCE_PATH} ${BUCKET}/${TRAVIS_REPO_SLUG}/${TRAVIS_BUILD_NUMBER}/${TARGET_PATH}
fi

## OSX stuff
if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    echo "Deploying Mac bundles ..."

    echo ${TRAVIS_BUILD_DIR}
    echo ${TRAVIS_BUILD_NUMBER}
    
    rclone copy ${TRAVIS_BUILD_DIR}/packages/bundles/review.app ${BUCKET}/releases/review/bundles/${TRAVIS_BUILD_NUMBER}
    # rclone copy /Users/travis/build/retest/bundles/packages/bundles/review-1.0.0.dmg ${BUCKET}/releases/review/bundles/${TRAVIS_BUILD_NUMBER}/

    find ${TRAVIS_BUILD_DIR}/packages

fi

## Windows stuff
if [[ $TRAVIS_OS_NAME == 'windows' ]]; then
    echo "Deploying Windows bundles ..."
fi
