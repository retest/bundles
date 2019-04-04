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

    rclone copy ${TRAVIS_BUILD_DIR}/packages/bundles/review.app ${BUCKET}/${TRAVIS_REPO_SLUG}/${TRAVIS_BUILD_NUMBER}/review.app
    rclone copy ${TRAVIS_BUILD_DIR}/packages/bundles/review-1.0.0.dmg ${BUCKET}/${TRAVIS_REPO_SLUG}/${TRAVIS_BUILD_NUMBER}/review-1.0.0.dmg
fi

## Windows stuff
if [[ $TRAVIS_OS_NAME == 'windows' ]]; then
    echo "Deploying Windows bundles ..."
fi
