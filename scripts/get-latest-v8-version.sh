#!/bin/bash
# Gets the latest stable V8 version from the official repository

set -e

# Clone V8 repository (shallow, tags only)
echo "Fetching V8 tags..."
git clone --depth=1 --no-checkout --filter=tree:0 \
  https://chromium.googlesource.com/v8/v8.git v8-temp 2>/dev/null || true

cd v8-temp

# Fetch all tags
git fetch --tags 2>/dev/null || true

# Get latest stable version (format: major.minor.patch)
# Exclude branch tags, beta, rc, etc.
LATEST=$(git tag -l | \
         grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | \
         grep -v '\-' | \
         sort -V | \
         tail -1)

cd ..
rm -rf v8-temp

echo "$LATEST"
