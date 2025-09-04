#!/bin/bash

# Script: kubectl_cp.sh
# Description: Copies files or directories to/from a Kubernetes pod.
# Usage:
#   To copy to pod:   ./kubectl_cp.sh to <local_source_path> <pod_destination_path>
#   To copy from pod: ./kubectl_cp.sh from <pod_source_path> <local_destination_path>

# Configuration
NAMESPACE="ix-ollama"
LABEL_SELECTOR="app.kubernetes.io/instance=ollama,app.kubernetes.io/name=ix-chart"

# Function to display usage
usage() {
    echo "Usage:"
    echo "  To copy to pod:   $0 to <local_source_path> <pod_destination_path>"
    echo "  To copy from pod: $0 from <pod_source_path> <local_destination_path>"
    echo ""
    echo "Examples:"
    echo "  $0 to ./example.txt /root/example.txt"
    echo "  $0 from /root/results.txt ./retrieved_results.txt"
    exit 1
}

# Function to display help
help_menu() {
    echo "Kubernetes Pod Copy Script"
    echo ""
    echo "This script copies files or directories to and from a specified path inside a Kubernetes pod."
    echo ""
    echo "Usage:"
    echo "  To copy to pod:   $0 to <local_source_path> <pod_destination_path>"
    echo "  To copy from pod: $0 from <pod_source_path> <local_destination_path>"
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message and exit"
    echo ""
    echo "Examples:"
    echo "  $0 to ./example.txt /root/example.txt"
    echo "  $0 from /root/results.txt ./retrieved_results.txt"
    exit 0
}

# Parse arguments
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    help_menu
fi

# Check if at least 4 arguments are provided for 'to' or 'from' commands
if [ "$#" -ne 4 ] && [ "$#" -ne 3 ]; then
    usage
fi

ACTION="$1"

# Get the pod name
echo "Fetching pod name with labels: $LABEL_SELECTOR in namespace: $NAMESPACE..."
POD_NAME=$(kubectl get pod -n "$NAMESPACE" \
  -l "$LABEL_SELECTOR" \
  -o jsonpath="{.items[?(@.status.phase=='Running')].metadata.name}" | head -n1)

# Check if a pod was found
if [ -z "$POD_NAME" ]; then
    echo "Error: No running pod found with labels: $LABEL_SELECTOR in namespace $NAMESPACE"
    exit 1
fi

echo "Found pod: $POD_NAME"

if [ "$ACTION" == "to" ]; then
    # Copy to pod
    LOCAL_SOURCE_PATH="$2"
    POD_DEST_PATH="$3"

    echo "Starting copy TO pod: $POD_NAME"
    echo "Local Source Path: $LOCAL_SOURCE_PATH"
    echo "Pod Destination Path: $POD_DEST_PATH"

    kubectl cp "$LOCAL_SOURCE_PATH" "$NAMESPACE/$POD_NAME":"$POD_DEST_PATH"

    if [ $? -eq 0 ]; then
        echo "✅ Successfully copied from $LOCAL_SOURCE_PATH to $NAMESPACE/$POD_NAME:$POD_DEST_PATH"
    else
        echo "❌ Failed to copy from $LOCAL_SOURCE_PATH to $NAMESPACE/$POD_NAME:$POD_DEST_PATH"
        exit 1
    fi

elif [ "$ACTION" == "from" ]; then
    # Copy from pod
    POD_SOURCE_PATH="$2"
    LOCAL_DEST_PATH="$3"

    echo "Starting copy FROM pod: $POD_NAME"
    echo "Pod Source Path: $POD_SOURCE_PATH"
    echo "Local Destination Path: $LOCAL_DEST_PATH"

    kubectl cp "$NAMESPACE/$POD_NAME":"$POD_SOURCE_PATH" "$LOCAL_DEST_PATH"

    if [ $? -eq 0 ]; then
        echo "✅ Successfully copied from $NAMESPACE/$POD_NAME:$POD_SOURCE_PATH to $LOCAL_DEST_PATH"
    else
        echo "❌ Failed to copy from $NAMESPACE/$POD_NAME:$POD_SOURCE_PATH to $LOCAL_DEST_PATH"
        exit 1
    fi

else
    echo "Error: Invalid action '$ACTION'. Use 'to' or 'from'."
    usage
fi
