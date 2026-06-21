#!/bin/bash

#usage ./release.sh <both_helm_app|helm|app> <major|minor|patch> 
#
#IF APP GETS UPDATED -> HELM ALSO GETS UPDATED

if [[ $1 = "app" ]]; then
  ./bump.sh minor helm_version
  ./bump.sh $2 app_version
fi

if [[ $1 = "helm" ]]; then
  ./bump.sh $2 helm_version
fi

if [[ $1 = "both_helm_app" ]]; then
  ./bump.sh $2 helm_version
  ./bump.sh $2 app_version
fi
