#!/bin/bash

# version.sh
# USAGE : ./version.sh <major|minor|patch> <fi


helm_version=$(cat helm_version)
app_version=$(cat app_version)

case "$1" in
  helm) sed  -i '' 's/^version:.*/version: '$helm_version'/g' helm/app/Chart.yaml ;;
  app)  sed  -i '' 's/^  tag:.*/  tag: \"'$app_version'\"/g' helm/app/values.yaml;\
    sed  -i '' 's/^appVersion:.*/appVersion: \"'$app_version'\"/g' helm/app/Chart.yaml;\
    sed  -i '' 's/^version = .*/version = \"'$app_version'\"/g' app/Cargo.toml ;;
esac



