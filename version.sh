#!/bin/bash

# version.sh
# USAGE : ./version.sh <helm|app|both_helm_app> <fi


helm_version=$(cat helm_version)
app_version=$(cat app_version)

sed -IE  "s/^version:.*/version: $helm_version/g" helm/app/Chart.yaml ;\
sed -IE  "s/^  tag:.*/  tag: \"$app_version\"/g" helm/app/values.yaml ;\
sed -IE "s/^appVersion:.*/appVersion: \"$app_version\"/g" helm/app/Chart.yaml ;\
sed -IE  "s/^version = .*/version = \'$app_version\'/g" app/Cargo.toml 
