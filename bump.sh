#!/bin/bash

# version.sh
# USAGE : ./bump.sh <major|minor|patch> <file>

current_version=$(cat $2)

IFS='.' read -r major minor patch <<< "$current_version"

case "$1" in
  major) major=$((major + 1)); minor=0; patch=0 ;;
  minor) minor=$((minor + 1)); patch=0 ;;
  patch) patch=$((patch + 1)) ;;
esac
new_version="$major.$minor.$patch"

echo $new_version > $2
echo $new_version
