#!/bin/bash
kubectl exec -it $(kubectl get pod -n ix-nginx-proxy-manager -l app.kubernetes.io/instance=nginx-proxy-manager,app.kubernetes.io/name=nginx-proxy-manager,pod.name=npm  -o jsonpath="{.items[?(@.status.phase=='Running')].metadata.name}" | head -n1) -n ix-nginx-proxy-manager -- /usr/bin/bash
