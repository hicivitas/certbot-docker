#!/bin/bash

if [ -z ${NAMESPACE} ]; then
  NAMESPACE="default"
fi

if [ -z ${KUBERNETES_USER} ]; then
  KUBERNETES_USER="default"
fi

if [ ! -z ${KUBERNETES_TOKEN} ]; then
  KUBERNETES_TOKEN=$KUBERNETES_TOKEN
fi

if [ ! -z ${KUBERNETES_SERVER} ]; then
  KUBERNETES_SERVER=$KUBERNETES_SERVER
fi

if [ ! -z ${KUBERNETES_CERT} ]; then
  KUBERNETES_CERT=${KUBERNETES_CERT}
fi

kubectl config set-credentials default --token=${KUBERNETES_TOKEN}
kubectl config set-cluster default --server=${KUBERNETES_SERVER} --insecure-skip-tls-verify=true
kubectl config set-context default --cluster=default --user=${KUBERNETES_USER}
kubectl config use-context default

# kubectl version
IFS=',' read -r -a DEPLOYMENTS <<< "${DEPLOYMENT}"
for DEPLOY in ${DEPLOYMENTS[@]}; do
  echo Deploying $DEPLOY to $KUBERNETES_SERVER
  kubectl patch deployment $DEPLOY -p \
  "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"restart-date\":\"`date +'%s'`\"}}}}}"
done
