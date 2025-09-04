#!/bin/bash
NAMESPACE="ix-ollama"
LABEL_SELECTOR="app.kubernetes.io/instance=ollama,app.kubernetes.io/name=ix-chart"

# Get the pod name
POD_NAME=$(kubectl get pod -n $NAMESPACE -l $LABEL_SELECTOR -o jsonpath="{.items[?(@.status.phase=='Running')].metadata.name}" | head -n1)

if [ -z "$POD_NAME" ]; then
  echo "No running pod found with labels: $LABEL_SELECTOR in namespace $NAMESPACE"
  exit 1
fi

kubectl cp "$1" "$NAMESPACE/$POD_NAME":"$2"

