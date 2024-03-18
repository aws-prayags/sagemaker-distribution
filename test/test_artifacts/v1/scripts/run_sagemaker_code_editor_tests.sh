#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

sagemaker-code-editor --version
echo "Verified that sagemaker-code-editor is installed"

# Check that extensions are installed correctly

# Define the base directory where to search
extensions_base_dir="/opt/amazon/sagemaker/sagemaker-code-editor-server-data/extensions"
if [[ ! -d $extensions_base_dir ]]; then
    echo "Extension base directory $extensions_base_dir does not exist."
    exit 1
fi

# TODO - we can use regex to ensure the exact extensions are being checked
installed_extensions_dirs=("ms-python.python-*" "ms-toolsai.jupyter-*" "yet-another-pattern*")
for pattern in "${installed_extensions_dirs[@]}"; do
    # Use the find command to search for directories matching the current pattern
    found_dirs=$(find "$extensions_base_dir" -maxdepth 1 -type d -name "$pattern")

    # Check if any directories were found for the current pattern
    if [[ -z $found_dirs ]]; then
        echo "Directory matching pattern '$pattern' does not exist in $extensions_base_dir."
        exit 1
    else
        echo "Directory exists for pattern '$pattern':"
        echo "$found_dirs"
    fi
done

# If the script reaches this point, all patterns have been found
echo "Verified that folders are present for extensions in $extensions_base_dir."

# check that settings file is persisted