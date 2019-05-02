#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

## Linux stuff
if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    VERSION=1.0.0
    ICON=favicon-96x96.png
    JDK_URL=https://cdn.azul.com/zulu/bin/zulu8.36.0.1-ca-fx-jdk8.0.202-linux_x64.tar.gz
    ICON_URL=https://retest.de/${ICON}

    echo "Downloading build dependencies ..."
    curl --location ${JDK_URL} --output ${TRAVIS_BUILD_DIR}/jdk.tar.gz
    curl --location ${ICON_URL} --output ${TRAVIS_BUILD_DIR}/${ICON}

    echo "Extracting build dependencies ..."
    tar xzf ${TRAVIS_BUILD_DIR}/jdk.tar.gz

    touch review/COPYING

    echo "Building Linux bundles ..."
    ${TRAVIS_BUILD_DIR}/zulu8.36.0.1-ca-fx-jdk8.0.202-linux_x64/bin/javapackager -deploy -native deb -Bicon=${TRAVIS_BUILD_DIR}/${ICON} -Bruntime=${TRAVIS_BUILD_DIR}/runtime -BshortcutHint=true -Bvendor="ReTest GmbH" -Bcategory="Development" -Bcopyright="ReTest GmbH" -Bemail="ops@retest.de" -BjvmOptions="-XX:+HeapDumpOnOutOfMemoryError" -BjvmOptions="-XX:-OmitStackTraceInFastThrow" -BappVersion="1.0.0" -BlicenseType=Proprietary -BlicenseFile=COPYING -outdir ${TRAVIS_BUILD_DIR}/packages -outfile review -srcdir ${TRAVIS_BUILD_DIR}/review -srcfiles "review.jar" -srcfiles "review" -srcfiles "review.bat" -srcfiles "review.exe" -srcfiles "COPYING" -appclass de.retest.gui.ReTestGui -name "review" -title "review"
    ${TRAVIS_BUILD_DIR}/zulu8.36.0.1-ca-fx-jdk8.0.202-linux_x64/bin/javapackager -deploy -native rpm -Bicon=${TRAVIS_BUILD_DIR}/${ICON} -Bruntime=${TRAVIS_BUILD_DIR}/runtime -BshortcutHint=true -Bvendor="ReTest GmbH" -Bcategory="Development" -Bcopyright="ReTest GmbH" -Bemail="ops@retest.de" -BjvmOptions="-XX:+HeapDumpOnOutOfMemoryError" -BjvmOptions="-XX:-OmitStackTraceInFastThrow" -BappVersion="1.0.0" -BlicenseType=Proprietary -BlicenseFile=COPYING -outdir ${TRAVIS_BUILD_DIR}/packages -outfile review -srcdir ${TRAVIS_BUILD_DIR}/review -srcfiles "review.jar" -srcfiles "review" -srcfiles "review.bat" -srcfiles "review.exe" -srcfiles "COPYING" -appclass de.retest.gui.ReTestGui -name "review" -title "review"

    find ${TRAVIS_BUILD_DIR}
fi

## OSX stuff
if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    echo "Building Mac bundles ..."

    VERSION=1.0.0
    ICON=favicon.icns
    JDK_URL=https://cdn.azul.com/zulu/bin/zulu8.36.0.1-ca-fx-jdk8.0.202-macosx_x64.tar.gz
    ICON_URL=https://retest.de/${ICON}

    curl --location ${JDK_URL} --output ${TRAVIS_BUILD_DIR}/jdk.tar.gz
    curl --location ${ICON_URL} --output ${TRAVIS_BUILD_DIR}/${ICON}

    tar xzf ${TRAVIS_BUILD_DIR}/jdk.tar.gz

    ${TRAVIS_BUILD_DIR}/zulu8.36.0.1-ca-fx-jdk8.0.202-macosx_x64/bin/javapackager -deploy -native app -Bicon=${TRAVIS_BUILD_DIR}/${ICON} -Bruntime=${TRAVIS_BUILD_DIR}/runtime -BshortcutHint=true -Bvendor="ReTest GmbH" -Bcategory="Development" -Bcopyright="ReTest GmbH" -Bemail="ops@retest.de" -BjvmOptions="-XX:+HeapDumpOnOutOfMemoryError" -BjvmOptions="-XX:-OmitStackTraceInFastThrow" -BappVersion="${VERSION}" -BlicenseType=Proprietary -outdir ${TRAVIS_BUILD_DIR}/packages -outfile review -srcdir ${TRAVIS_BUILD_DIR}/review -srcfiles "review.jar" -srcfiles "review" -srcfiles "review.bat" -srcfiles "review.exe" -appclass de.retest.gui.ReTestGui -name "review" -title "review"
    ${TRAVIS_BUILD_DIR}/zulu8.36.0.1-ca-fx-jdk8.0.202-macosx_x64/bin/javapackager -deploy -native dmg -Bicon=${TRAVIS_BUILD_DIR}/${ICON} -Bruntime=${TRAVIS_BUILD_DIR}/runtime -BshortcutHint=true -Bvendor="ReTest GmbH" -Bcategory="Development" -Bcopyright="ReTest GmbH" -Bemail="ops@retest.de" -BjvmOptions="-XX:+HeapDumpOnOutOfMemoryError" -BjvmOptions="-XX:-OmitStackTraceInFastThrow" -BappVersion="${VERSION}" -BlicenseType=Proprietary -outdir ${TRAVIS_BUILD_DIR}/packages -outfile review -srcdir ${TRAVIS_BUILD_DIR}/review -srcfiles "review.jar" -srcfiles "review" -srcfiles "review.bat" -srcfiles "review.exe" -appclass de.retest.gui.ReTestGui -name "review" -title "review"

    find ${TRAVIS_BUILD_DIR}
fi

## Windows stuff
if [[ $TRAVIS_OS_NAME == 'windows' ]]; then
    echo "Building Windows bundles ..."
fi
