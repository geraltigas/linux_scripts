#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to display error messages in red
echo_error() {
    echo -e "${RED}$1${NC}"
}

# Function to display success messages in green
echo_success() {
    echo -e "${GREEN}$1${NC}"
}

# Set default build type to Release
BUILD_TYPE="Release"

# Check if an argument is provided and update build type
if [ $# -eq 1 ]; then
    BUILD_TYPE=$1
fi

# Validate build type
if [ "$BUILD_TYPE" != "Debug" ] && [ "$BUILD_TYPE" != "Release" ]; then
    echo_error "Invalid build type. Use either Debug or Release."
    exit 1
fi

# Create a build directory and navigate into it
mkdir -p build
cd build

# Run CMake with the specified build type
cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE ..

# Check if CMake was successful
if [ $? -ne 0 ]; then
    echo_error "CMake configuration failed"
    exit 1
fi

echo_success "CMake configuration successful"
