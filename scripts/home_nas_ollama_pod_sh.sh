#!/bin/bash
#
POD_NAME=$(kubectl get pod -n ix-ollama \
  -l app.kubernetes.io/instance=ollama,app.kubernetes.io/name=ix-chart \
  -o jsonpath="{.items[?(@.status.phase=='Running')].metadata.name}" | head -n1)

kubectl exec -it ${POD_NAME} -n ix-ollama -- /usr/bin/bash
