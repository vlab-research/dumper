#!/bin/bash
set -e
set -o pipefail

gcloud auth activate-service-account --key-file=/keys/key.json

TIMESTAMP=$(date +%Y-%m-%dT%H:%M)

cockroach dump chatroach --insecure --host $CHATBASE_HOST > /mounted/"$TIMESTAMP".sql

echo "DATABASE DUMPED."

gzip /mounted/"$TIMESTAMP".sql
gsutil -m cp /mounted/"$TIMESTAMP".sql.gz $DUMPER_LOCATION

echo "BACKUP COPIED FILE AT $TIMESTAMP."

{
gsutil ls $DUMPER_LOCATION | grep "$(date --date '-6 day' --iso-8601)" | tail -n +2 | gsutil -m rm -I
} || {
  echo "NO OLD FILES FOR CLEANUP"
}

echo "BACKUP FINISHED."
