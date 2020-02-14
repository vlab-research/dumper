#!/bin/bash
set -e
set -o pipefail

gcloud auth activate-service-account --key-file=/keys/key.json

TIMESTAMP=$(date +%Y-%m-%dT%H:%M)

cockroach dump chatroach --insecure --host $CHATBASE_HOST > "$TIMESTAMP".sql

gsutil cp "$TIMESTAMP".sql $DUMPER_LOCATION

echo "BACKUP FINISHED COPYING FILE AT $TIMESTAMP!"
