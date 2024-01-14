#!/bin/bash

# Check if at least one package name is provided
if [ $# -eq 0 ]; then
    echo "Please provide at least one package name."
    exit 1
fi

# Purging each specified package
for pkg in "$@"
do
    echo "Purging $pkg..."
    sudo apt purge -y $pkg
done

# Removing unused dependencies
echo "Performing autoremove..."
sudo apt autoremove -y

echo "Operation completed."

