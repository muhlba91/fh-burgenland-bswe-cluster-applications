#!/bin/bash

echo "deleting local configuration files..."
rm -f vclusters/configs/cluster-*.conf
rm -f vclusters/configs/cluster-*.zip

echo "deleting configuration from the cluster-access pod..."
kubectl -n fh-burgenland-bswe-cluster-access get pod -l  "app.kubernetes.io/name=cluster-access" -o jsonpath="{.items[0].metadata.name}" | xargs -I {} kubectl -n fh-burgenland-bswe-cluster-access exec {} -- sh -c "rm /usr/share/nginx/html/files/cluster-*.zip"
