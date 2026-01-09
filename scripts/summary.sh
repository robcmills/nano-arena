#!/bin/bash

# Love2D Project Summary Script

# Find all Lua files in current directory and subdirectories
lua_files=$(find . -name "*.lua" -type f)

# Count files
file_count=$(echo "$lua_files" | grep -c "\.lua$")

# Handle case of no files found
if [ "$file_count" -eq 0 ]; then
    echo "No .lua files found in current directory"
    exit 0
fi

# Count lines of code (excluding empty lines)
loc=$(cat $lua_files 2>/dev/null | grep -v "^[[:space:]]*$" | wc -l)

# Count tokens (words)
tokens=$(cat $lua_files 2>/dev/null | wc -w)

# Output summary
echo "=== Love2D Project Summary ==="
echo "Files:  $file_count"
echo "Lines:  $loc"
echo "Tokens: $tokens"
