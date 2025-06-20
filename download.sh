#!/usr/bin/env bash

set -eu

if [ ! -d "angle" ]; then
    mkdir angle
    cd angle
    fetch angle
else
    cd angle
fi

gclient sync
