#!/bin/bash

RCLONE_VERSION="v1.47.0"
RCLONE_BASE_URL="https://downloads.rclone.org/${RCLONE_VERSION}"

RUNTIME_BUILD=7
RUNTIME_VERSION="11.0.3"
RUNTIME_BASE_URL="https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-${RUNTIME_VERSION}%2B${RUNTIME_BUILD}"

REVIEW_VERSION="1.0.0"
REVIEW_URL=https://retest.de/review/review-${REVIEW_VERSION}.zip

ZULU_VERSION="8.36.0.1"
ZULU_JDK_VERSION="8.0.202"
ZULU_BASE_URL="https://cdn.azul.com/zulu/bin"

install_bundle_unix() {
    echo "Installing bundle runtime ..."
    RUNTIME_FILE=$1
    RUNTIME_URL="${RUNTIME_BASE_URL}/${RUNTIME_FILE}"

    curl --location ${RUNTIME_URL} --output ${TRAVIS_BUILD_DIR}/runtime.tar.gz
    tar xzf ${TRAVIS_BUILD_DIR}/runtime.tar.gz
    mv ${TRAVIS_BUILD_DIR}/jdk-${RUNTIME_VERSION}+${RUNTIME_BUILD}-jre ${TRAVIS_BUILD_DIR}/runtime

    find ${TRAVIS_BUILD_DIR}
}

install_rclone_unix() {
    echo "Installing rclone ..."
    RCLONE_FILE="rclone-${RCLONE_VERSION}-${TRAVIS_OS_NAME}-amd64"
    RCLONE_ZIP="${RCLONE_FILE}.zip"
    RCLONE_URL="${RCLONE_BASE_URL}/${RCLONE_ZIP}"

    wget --quiet ${RCLONE_URL}
    unzip -j -q "${RCLONE_ZIP}" "${RCLONE_FILE}/rclone" -d ${HOME}/bin/
}

install_review_unix() {
    echo "Installing review ..."
    curl --location ${REVIEW_URL} --output ${TRAVIS_BUILD_DIR}/review.zip
    unzip -q review.zip -d review
}

install_zulufx_unix() {
    echo "Installing Azul ZuluFX ..."
    ZULU_FILE=$1
    ZULU_URL="${ZULU_BASE_URL}/${ZULU_FILE}.tar.gz"

    curl --location ${ZULU_URL} --output ${TRAVIS_BUILD_DIR}/zulufx.tar.gz
    tar xzf ${TRAVIS_BUILD_DIR}/zulufx.tar.gz
    mv ${TRAVIS_BUILD_DIR}/${ZULU_FILE} ${TRAVIS_BUILD_DIR}/zulufx
}

## Linux stuff
if [[ ${TRAVIS_OS_NAME} == 'linux' ]]; then
    echo "Installing Linux dependencies ..."
    install_bundle_unix "OpenJDK11U-jre_x64_linux_hotspot_${RUNTIME_VERSION}_${RUNTIME_BUILD}.tar.gz"
    install_zulufx_unix "zulu${ZULU_VERSION}-ca-fx-jdk${ZULU_JDK_VERSION}-linux_x64"
    install_rclone_unix
    install_review_unix
fi

## OSX stuff
if [[ ${TRAVIS_OS_NAME} == 'osx' ]]; then
    echo "Installing Mac dependencies ..."
    install_bundle_unix "OpenJDK11U-jre_x64_mac_hotspot_${RUNTIME_VERSION}_${RUNTIME_BUILD}.tar.gz"
    install_zulufx_unix "zulu${ZULU_VERSION}-ca-fx-jdk${ZULU_JDK_VERSION}-macosx_x64"
    install_rclone_unix
    install_review_unix
fi

## Windows stuff
if [[ ${TRAVIS_OS_NAME} == 'windows' ]]; then
    echo "Installing Windows dependencies ..."
fi
