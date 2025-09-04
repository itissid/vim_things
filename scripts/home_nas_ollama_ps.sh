#!/usr/bin/env bash
#
# Usage:
#   port_forward_ollama.sh <LOCAL_PORT> <POD_PORT>
#
# Example:
#   port_forward_ollama.sh 9999 8888
#

# Ensure we have exactly 2 arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 <LOCAL_PORT> <POD_PORT>"
  exit 1
fi

# 1) Parse arguments
localPort="$1"
podPort="$2"

# 2) Use our custom kubeconfig for TrueNAS
export KUBECONFIG=~/truenas-kubeconfig.yaml

# 3) Check if this localPort->podPort is already forwarded
if pgrep -f "kubectl port-forward.*${localPort}:${podPort}" > /dev/null; then
  echo "It looks like port ${localPort} -> ${podPort} is already forwarded. Exiting."
  exit 1
fi

# 4) Get the pod name in ix-ollama namespace with specified labels
POD_NAME=$(kubectl get pod -n ix-ollama \
  -l app.kubernetes.io/instance=ollama,app.kubernetes.io/name=ix-chart \
  -o jsonpath="{.items[?(@.status.phase=='Running')].metadata.name}" | head -n1)

if [ -z "$POD_NAME" ]; then
  echo "No running pod found in namespace ix-ollama with labels (ollama, ix-chart)."
  exit 1
fi

echo "Found pod: $POD_NAME"

# 5) Start port-forwarding in the background so it doesn't block the terminal
# We redirect output to a log so it doesn't clutter the console.
LOG_FILE="kubectl_port_forward.log"

nohup kubectl port-forward -n ix-ollama "$POD_NAME" "${localPort}:${podPort}" > "$LOG_FILE" 2>&1 &

echo "Port-forward started for pod: $POD_NAME ($localPort -> $podPort)."
echo "Check $LOG_FILE for details."

# 6) Optionally wait a second and verify it started
sleep 1
if pgrep -f "kubectl port-forward.*${localPort}:${podPort}" > /dev/null; then
  echo "Port-forward is running in the background."
else
  echo "Port-forward may have failed. Check $LOG_FILE."
fi

exit 0
