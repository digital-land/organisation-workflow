#! /bin/bash

set -e

TODAY=$(date +%Y-%m-%d)
echo "Building organisation package on $TODAY"

if [ -z "$COLLECTION_DATASET_BUCKET_NAME" ]; then
    echo "assign value to COLLECTION_DATASET_BUCKET_NAME to save to a bucket"
fi

echo Install dependencies
make init

pip install -r requirements.txt

echo Build the dataset
make

if [ -n "$COLLECTION_DATASET_BUCKET_NAME" ]; then
    echo Push organisation.csv to S3
    make push
fi

