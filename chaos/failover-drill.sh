#!/usr/bin/env bash
set -euo pipefail

PRIMARY_CTX="${PRIMARY_CTX:-eks-primary}"
SECONDARY_CTX="${SECONDARY_CTX:-eks-secondary}"
NAMESPACE="${NAMESPACE:-dr-demo}"

echo "Starting DR drill..."
echo "Primary context:   $PRIMARY_CTX"
echo "Secondary context: $SECONDARY_CTX"
echo "Namespace:         $NAMESPACE"

echo "[1/5] Check primary deployment"
kubectl --context "$PRIMARY_CTX" -n "$NAMESPACE" get deploy dr-demo

echo "[2/5] Scale down app in primary region"
kubectl --context "$PRIMARY_CTX" -n "$NAMESPACE" scale deploy dr-demo --replicas=0

echo "[3/5] Validate secondary still serving"
kubectl --context "$SECONDARY_CTX" -n "$NAMESPACE" get pods -l app=dr-demo

echo "[4/5] Run Route53/endpoint verification manually"
echo " - Check health checks in Route53 console"
echo " - Confirm traffic resolves to secondary endpoint"

echo "[5/5] Restore primary app"
kubectl --context "$PRIMARY_CTX" -n "$NAMESPACE" scale deploy dr-demo --replicas=2
kubectl --context "$PRIMARY_CTX" -n "$NAMESPACE" rollout status deploy/dr-demo

echo "DR drill completed."
