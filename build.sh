#!/usr/bin/env bash

set -e

echo "Cleaning up..."
make clean

# Build Cyclone64
echo "Building Cyclone64..."
make -j4
make install || sudo -E make install

echo "Build done!"
