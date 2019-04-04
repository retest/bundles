#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

BUCKET='DO:retest'
SOURCE_PATH=${TRAVIS_BUILD_DIR}/packages
TARGET_PATH='bundles'

## Linux stuff
if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    echo "Deploying Linux bundles ..."

    # rclone copy ${SOURCE_PATH} ${BUCKET}/${TRAVIS_REPO_SLUG}/${TRAVIS_BUILD_NUMBER}/${TARGET_PATH}
fi

## OSX stuff
if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    echo "Deploying Mac bundles ..."

    rclone copy ${SOURCE_PATH} ${BUCKET}/${TRAVIS_REPO_SLUG}/${TRAVIS_BUILD_NUMBER}/${TARGET_PATH}
fi

## Windows stuff
if [[ $TRAVIS_OS_NAME == 'windows' ]]; then
    echo "Deploying Windows bundles ..."
fi
