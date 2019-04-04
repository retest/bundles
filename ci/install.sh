#!/bin/bash

## Linux stuff
if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    echo "Installing Linux dependencies ..."

    OS="linux"
    URL="https://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-${OS}-amd64.zip"
    wget --quiet ${URL}
    unzip -j -q "rclone-${RCLONE_VERSION}-${OS}-amd64.zip" "rclone-${RCLONE_VERSION}-${OS}-amd64/rclone" -d ${HOME}/bin/
fi

## OSX stuff
if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    echo "Installing Mac dependencies ..."

    OS="osx"
    URL="https://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-${OS}-amd64.zip"
    wget --quiet ${URL}
    unzip -j -q "rclone-${RCLONE_VERSION}-${OS}-amd64.zip" "rclone-${RCLONE_VERSION}-${OS}-amd64/rclone" -d ${HOME}/bin/
fi

## Windows stuff
if [[ $TRAVIS_OS_NAME == 'windows' ]]; then
    echo "Installing Windows dependencies ..."
fi
