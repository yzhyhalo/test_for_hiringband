#!/bin/bash

# version.sh
# USAGE : ./version.sh <helm|app|both_helm_app> <fi


helm_version=$(cat helm_version)
app_version=$(cat app_version)

sed -E  "s/^version:.*/version: $helm_version/g" -I helm/app/Chart.yaml >helm/app/Chart.yaml 
sed -E  "s/^  tag:.*/  tag: \"$app_version\"/g" -I helm/app/values.yaml >helm/app/values.yaml 
sed -E "s/^appVersion:.*/appVersion: \"$app_version\"/g" -I  helm/app/Chart.yaml  > helm/app/Chart.yaml
sed -E  "s/^version = .*/version = \'$app_version\'/g" -I app/Cargo.toml >app/Cargo.toml  
