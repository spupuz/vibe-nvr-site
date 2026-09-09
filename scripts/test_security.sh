#!/bin/bash
# Mock test for CI/CD

echo "Running security checks..."

# Check if Math.random is used without getRandomValues fallback in scripts.html
if grep -q "Math.random" src/scripts.html; then
    if ! grep -q "window.crypto.getRandomValues" src/scripts.html; then
        echo "FAIL: Math.random used without cryptographically secure fallback in src/scripts.html"
        exit 1
    else
        echo "Security tests passed."
    fi
else
    echo "Security tests passed."
fi

exit 0
