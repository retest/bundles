#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

## Linux stuff
if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    VERSION=1.0.0
    ICON=favicon-96x96.png
    ICON_URL=https://assets.retest.org/retest/ci/favicons/${ICON}

    echo "Downloading build dependencies ..."
    curl --location ${ICON_URL} --output ${TRAVIS_BUILD_DIR}/${ICON}

    echo "Building Linux bundles ..."
    ${TRAVIS_BUILD_DIR}/jdk-14/bin/jpackage --type deb --verbose -d ${TRAVIS_BUILD_DIR}/packages -i ${TRAVIS_BUILD_DIR}/review -n review --main-class de.retest.gui.ReTestGui --main-jar review.jar --icon ${TRAVIS_BUILD_DIR}/${ICON} --runtime-image ${TRAVIS_BUILD_DIR}/runtime --vendor "ReTest GmbH" --copyright "ReTest GmbH" --app-version "${VERSION}" --linux-package-name "review"
fi

## OSX stuff
if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    VERSION=1.0.0
    ICON=favicon.icns
    ICON_URL=https://assets.retest.org/retest/ci/favicons/${ICON}

    echo "Downloading build dependencies ..."
    curl --location ${ICON_URL} --output ${TRAVIS_BUILD_DIR}/${ICON}

    echo "Building macOS bundles ..."
    ${TRAVIS_BUILD_DIR}/jdk-14.jdk/Contents/Home/bin/jpackage --type app-image --verbose -d ${TRAVIS_BUILD_DIR}/packages -i ${TRAVIS_BUILD_DIR}/review -n review --main-class de.retest.gui.ReTestGui --main-jar review.jar --icon ${TRAVIS_BUILD_DIR}/favicon.icns --runtime-image ${TRAVIS_BUILD_DIR}/runtime --vendor "ReTest GmbH" --copyright "ReTest GmbH" --app-version "${VERSION}" --mac-package-name "review"

    echo "Adjust Info.plist to open review with browser link ..."
    /usr/libexec/PlistBuddy -c "add :CFBundleURLTypes array" -c "add :CFBundleURLTypes:0 dict" -c "add :CFBundleURLTypes:0:CFBundleURLSchemes array" -c "add :CFBundleURLTypes:0:CFBundleURLSchemes:0 string retest" -c "add :CFBundleURLTypes:0:CFBundleURLName string " ${TRAVIS_BUILD_DIR}/packages/review.app/Contents/Info.plist

    cd ${TRAVIS_BUILD_DIR}/packages
    zip -r -q review.zip review.app
fi

## Windows stuff
if [[ $TRAVIS_OS_NAME == 'windows' ]]; then
    echo "Building Windows bundles ..."
fi
