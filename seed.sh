#!/bin/bash
set -e
set -o pipefail

gcloud auth activate-service-account --key-file=/keys/key.json

BACKUP_FILE=$(gsutil ls $DUMPER_LOCATION | sort -k 2 | tail -n 2 | head -1)

gsutil cp $BACKUP_FILE backup.sql

echo "CREATE DATABASE chatroach;" | cockroach sql --insecure --host $CHATBASE_HOST --database $CHATBASE_DATABASE

cat backup.sql | cockroach sql --insecure --host $CHATBASE_HOST --database $CHATBASE_DATABASE

cat users.sql | cockroach sql --insecure --host $CHATBASE_HOST

echo "DUMPER FINISHED SEEDING $BACKUP_FILE!"
