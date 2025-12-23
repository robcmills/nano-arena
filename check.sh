#!/bin/bash

echo "Checking project for lua errors..."
lua-language-server --check .

echo "Created log file: /Users/robcmills/.cache/lua-language-server/log/check.json"
cat /Users/robcmills/.cache/lua-language-server/log/check.json | jq .
