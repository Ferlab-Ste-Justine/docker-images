#!/bin/sh

aws eks update-kubeconfig --name "$EKS_CLUSTER_NAME" --region "$AWS_REGION"

API_HOST=$(aws eks describe-cluster \
  --name "$EKS_CLUSTER_NAME" --region "$AWS_REGION" \
  --query 'cluster.endpoint' --output text | sed 's|https://||')
echo ">> EKS API host: $API_HOST"

if [ ! -f "/etc/hosts-original" ]; then
    cp /etc/hosts /etc/hosts-original
fi

printf "%s\n127.0.0.1 $API_HOST\n" "$(cat /etc/hosts-original)" > /etc/hosts

CTX=$(kubectl config current-context)
CLUSTER_KEY=$(kubectl config view -o "jsonpath={.contexts[?(@.name=='$CTX')].context.cluster}")
kubectl config set-cluster "$CLUSTER_KEY" --server="https://${API_HOST}:${EKS_TUNNEL_PORT}"