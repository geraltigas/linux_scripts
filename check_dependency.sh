#!/bin/bash

# Check if a package name is provided
if [ -z "$1" ]; then
    echo "Please provide a package name."
    exit 1
fi

# The package to be checked
PACKAGE_NAME=$1

# List all packages that depend on the specified package
echo "Listing packages that depend on '$PACKAGE_NAME' and their installation status:"

for pkg in $(apt-cache rdepends $PACKAGE_NAME | grep -v "^ " | tail -n +3); do
    echo -n "Package $pkg: "
    
    # Check if the package is installed
    if dpkg -l | grep -q "^ii  $pkg "; then
        echo "Installed"
    else
        echo "Not installed"
    fi
done

