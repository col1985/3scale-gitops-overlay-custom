#!/usr/bin/env bash

set -e

cat << EOF | oc apply -f -
apiVersion: v1
kind: Secret
metadata:
  creationTimestamp: null
  name: aws-auth
stringData:
  AWS_ACCESS_KEY_ID: "$(echo $ACCESS_CREDS | cut -f 1)"
  AWS_SECRET_ACCESS_KEY: "$(echo $ACCESS_CREDS | cut -f 2)"
  AWS_BUCKET: "$S3_BUCKET"
  AWS_REGION: "$REGION"
type: Opaque
EOF