#!/bin/bash
set -e
set -o pipefail

gcloud auth activate-service-account --key-file=/keys/key.json

TIMESTAMP=$(date +%Y-%m-%dT%H:%M)

cockroach dump chatroach --insecure --host $CHATBASE_HOST > "$TIMESTAMP".sql

echo "DATABASE DUMPED."

gzip "$TIMESTAMP".sql
gsutil cp "$TIMESTAMP".sql.gz $DUMPER_LOCATION

echo "BACKUP COPIED FILE AT $TIMESTAMP."

gsutil ls $DUMPER_LOCATION | grep "$(date --date '-6 day' --iso-8601)" | tail -n +2 | gsutil rm -I

echo "BACKUP FINISHED."
