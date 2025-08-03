#!/bin/bash

# Check if file argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <input_file>"
    echo "Example: $0 colors.txt"
    exit 1
fi

input_file="$1"

# Check if file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found."
    exit 1
fi

# Process the file and build EZA_COLORS format
eza_colors=""

while IFS= read -r line; do
    # Skip empty lines
    [ -z "$line" ] && continue
    
    # Skip comment lines (lines starting with #)
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    
    # Remove inline comments (everything after #)
    line=$(echo "$line" | sed 's/#.*//')
    
    # Split on whitespace (handles multiple spaces/tabs)
    key=$(echo "$line" | awk '{print $1}')
    value=$(echo "$line" | awk '{print $2}')
    
    # Skip if we don't have both key and value
    [ -z "$key" ] || [ -z "$value" ] && continue
    
    # Add to EZA_COLORS string
    if [ -z "$eza_colors" ]; then
        eza_colors="${key}=${value}"
    else
        eza_colors="${eza_colors}:${key}=${value}"
    fi
done < "$input_file"

# Output the result
echo "\"$eza_colors\""