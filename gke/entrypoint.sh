#!/bin/bash

printf "#-----------------------------------------------------------------------------------\n"
printf "#\n"
printf "#   CoolOps.io GKE deployment image\n"
printf "#\n"
printf "#   Docker image: ${DOCKER_IMAGE}\n"
printf "#   Deployments that will be updated: ${KUBERNETES_DEPLOYMENTS}\n"
printf "#   Namespace: ${KUBERNETES_NAMESPACE}\n"
printf "#\n"
printf "#-----------------------------------------------------------------------------------\n\n\n"

set -e

echo $GCLOUD_KEY_JSON | base64 -d > gcloud-service-key.json
gcloud auth activate-service-account --key-file gcloud-service-key.json

gcloud config set project $GCLOUD_PROJECT_ID
gcloud config set compute/zone $GCLOUD_COMPUTE_ZONE
gcloud container clusters get-credentials $GCLOUD_CLUSTER_NAME

IFS=',' read -r -a deployments <<< "$KUBERNETES_DEPLOYMENTS"

printf "\n\n"

for deployment in "${deployments[@]}"
do
  kubectl set image deployment/${deployment} -n $KUBERNETES_NAMESPACE ${deployment}=$DOCKER_IMAGE
done
