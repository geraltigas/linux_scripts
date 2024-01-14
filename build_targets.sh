#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display error messages in red
echo_error() {
    echo -e "${RED}$1${NC}"
}

# Function to display informational messages in yellow
echo_info() {
    echo -e "${YELLOW}$1${NC}"
}

# Function to display success messages in green
echo_success() {
    echo -e "${GREEN}$1${NC}"
}

# Check if CMake build directory exists
BUILD_DIR="build"
if [ ! -d "$BUILD_DIR" ]; then
    echo_error "Build directory ($BUILD_DIR) not found. Please ensure you have a 'build' directory and have run CMake configuration."
    exit 1
fi

# Change to the build directory
cd "$BUILD_DIR"

# Extract available targets
echo_info "Extracting available build targets..."
TARGETS=$(cmake --build . --target help | grep -E '^\.\.\. [^ ]+$' | awk '{print $2}')

# Check if target extraction was successful
if [ -z "$TARGETS" ]; then
    echo_error "Failed to extract build targets."
    exit 1
fi

# Display available targets
echo_info "Available build targets:"
select TARGET in $TARGETS; do
    if [ -n "$TARGET" ]; then
        echo_info "Building target: $TARGET"
        cmake --build . --target "$TARGET" -- -j$(nproc)

        # Check if build was successful
        if [ $? -eq 0 ]; then
            echo_success "Build successful."
        else
            echo_error "Build failed."
        fi
        break
    else
        echo_error "Invalid selection. Please try again."
    fi
done
