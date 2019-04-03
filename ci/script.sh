#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

BUCKET='DO:retest'
SOURCE_PATH=${TRAVIS_BUILD_DIR}/packages
TARGET_PATH='bundles'

## Linux stuff
if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    echo "Building Linux bundles ..."
fi

## OSX stuff
if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    echo "Building Mac bundles ..."

    VERSION=1.0.0
    ICON=favicon.icns
    REVIEW_URL=https://retest.de/review/review-${VERSION}.zip
    JDK_URL=https://cdn.azul.com/zulu/bin/zulu8.36.0.1-ca-fx-jdk8.0.202-macosx_x64.tar.gz
    RUNTIME_URL=https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.2%2B9/OpenJDK11U-jre_x64_mac_hotspot_11.0.2_9.tar.gz
    ICON_URL=https://retest.de/${ICON}

    curl --location ${JDK_URL} --output ${TRAVIS_BUILD_DIR}/jdk.tar.gz
    curl --location ${RUNTIME_URL} --output ${TRAVIS_BUILD_DIR}/runtime.tar.gz
    curl --location ${REVIEW_URL} --output ${TRAVIS_BUILD_DIR}/review.zip
    curl --location ${ICON_URL} --output ${TRAVIS_BUILD_DIR}/${ICON}

    tar xzf ${TRAVIS_BUILD_DIR}/jdk.tar.gz
    tar xzf ${TRAVIS_BUILD_DIR}/runtime.tar.gz
    unzip -q review.zip -d review

    ${TRAVIS_BUILD_DIR}/zulu8.36.0.1-ca-fx-jdk8.0.202-macosx_x64/bin/javapackager -deploy -native image -Bicon=${TRAVIS_BUILD_DIR}/${ICON} -Bruntime=${TRAVIS_BUILD_DIR}/jdk-11.0.2+9-jre -BshortcutHint=true -Bvendor="ReTest GmbH" -Bcategory="Development" -Bcopyright="ReTest GmbH" -Bemail="ops@retest.de" -BjvmOptions="-XX:+HeapDumpOnOutOfMemoryError" -BjvmOptions="-XX:-OmitStackTraceInFastThrow" -BappVersion="${VERSION}" -BlicenseType=Proprietary -outdir ${TRAVIS_BUILD_DIR}/packages -outfile review -srcdir ${TRAVIS_BUILD_DIR}/review -srcfiles "review.jar" -srcfiles "review" -srcfiles "review.bat" -srcfiles "review.exe" -appclass de.retest.gui.ReTestGui -name "review" -title "review"
    ${TRAVIS_BUILD_DIR}/zulu8.36.0.1-ca-fx-jdk8.0.202-macosx_x64/bin/javapackager -deploy -native dmg -Bicon=${TRAVIS_BUILD_DIR}/${ICON} -Bruntime=${TRAVIS_BUILD_DIR}/jdk-11.0.2+9-jre -BshortcutHint=true -Bvendor="ReTest GmbH" -Bcategory="Development" -Bcopyright="ReTest GmbH" -Bemail="ops@retest.de" -BjvmOptions="-XX:+HeapDumpOnOutOfMemoryError" -BjvmOptions="-XX:-OmitStackTraceInFastThrow" -BappVersion="${VERSION}" -BlicenseType=Proprietary -outdir ${TRAVIS_BUILD_DIR}/packages -outfile review -srcdir ${TRAVIS_BUILD_DIR}/review -srcfiles "review.jar" -srcfiles "review" -srcfiles "review.bat" -srcfiles "review.exe" -appclass de.retest.gui.ReTestGui -name "review" -title "review"

    rclone copy ${TRAVIS_BUILD_DIR}/${SOURCE_PATH} ${BUCKET}/${TRAVIS_REPO_SLUG}/${TRAVIS_BUILD_NUMBER}/${TARGET_PATH}
fi

## Windows stuff
if [[ $TRAVIS_OS_NAME == 'windows' ]]; then
    echo "Building Windows bundles ..."
fi
