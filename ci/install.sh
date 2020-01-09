#!/bin/bash

RCLONE_VERSION="v1.49.5"
RCLONE_BASE_URL="https://downloads.rclone.org/${RCLONE_VERSION}"

RUNTIME_BUILD=7
RUNTIME_VERSION="11.0.3"
RUNTIME_BASE_URL="https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-${RUNTIME_VERSION}%2B${RUNTIME_BUILD}"

REVIEW_VERSION="1.0.0"
REVIEW_URL=https://assets.retest.org/releases/review/review-${REVIEW_VERSION}.zip

JDK14_EARLY_ACCESS_URL="https://download.java.net/java/early_access/jdk14/27/GPL"

install_bundle_unix() {
    echo "Installing bundle runtime ..."
    RUNTIME_FILE=$1
    RUNTIME_URL="${RUNTIME_BASE_URL}/${RUNTIME_FILE}"

    curl --location ${RUNTIME_URL} --output ${TRAVIS_BUILD_DIR}/runtime.tar.gz
    tar xzf ${TRAVIS_BUILD_DIR}/runtime.tar.gz
    mv ${TRAVIS_BUILD_DIR}/jdk-${RUNTIME_VERSION}+${RUNTIME_BUILD}-jre ${TRAVIS_BUILD_DIR}/runtime
}

install_jdk14() {
    echo "Installing JDK 14 Early-Access Builds ..."
    JDK14_FILE=$1
    JDK14_URL="${JDK14_EARLY_ACCESS_URL}/${JDK14_FILE}"

    curl --location ${JDK14_URL} --output ${TRAVIS_BUILD_DIR}/jdk14.tar.gz
    tar xzf ${TRAVIS_BUILD_DIR}/jdk14.tar.gz
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

## Linux stuff
if [[ ${TRAVIS_OS_NAME} == 'linux' ]]; then
    echo "Installing Linux dependencies ..."
    install_bundle_unix "OpenJDK11U-jre_x64_linux_hotspot_${RUNTIME_VERSION}_${RUNTIME_BUILD}.tar.gz"
    install_jdk14 "openjdk-14-ea+27_linux-x64_bin.tar.gz"
    install_rclone_unix
    install_review_unix
fi

## OSX stuff
if [[ ${TRAVIS_OS_NAME} == 'osx' ]]; then
    echo "Installing Mac dependencies ..."
    install_bundle_unix "OpenJDK11U-jre_x64_mac_hotspot_${RUNTIME_VERSION}_${RUNTIME_BUILD}.tar.gz"
    install_jdk14 "openjdk-14-ea+27_osx-x64_bin.tar.gz"
    install_rclone_unix
    install_review_unix
fi

## Windows stuff
if [[ ${TRAVIS_OS_NAME} == 'windows' ]]; then
    echo "Installing Windows dependencies ..."
fi
