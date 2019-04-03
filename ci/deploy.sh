#!/bin/bash

## Linux stuff
if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    echo "Deploying Linux bundles ..."
fi

## OSX stuff
if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    echo "Deploying Mac bundles ..."
fi

## Windows stuff
if [[ $TRAVIS_OS_NAME == 'windows' ]]; then
    echo "Deploying Windows bundles ..."
fi
