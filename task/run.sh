#! /bin/bash

set -e

TODAY=$(date +%Y-%m-%d)
echo "Building organisation package on $TODAY"

if [ -z "$COLLECTION_DATASET_BUCKET_NAME" ]; then
    echo "assign value to COLLECTION_DATASET_BUCKET_NAME to save to a bucket"
fi

echo Install dependencies
make init

git clone https://github.com/digital-land/digital-land-python.git
cd digital-land-python
git checkout create-organisation
pip install -e .
cd ..

echo Build the dataset
make

if [ -n "$COLLECTION_DATASET_BUCKET_NAME" ]; then
    echo Push organisation.csv to S3
    make push
fi

