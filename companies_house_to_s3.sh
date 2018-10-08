#!/bin/bash

set -e

tmpdir=$(mktemp -d)

date=$(date "+$DATE_FORMAT")

cd $tmpdir

wget http://download.companieshouse.gov.uk/$URL_PATH-$date.zip

unzip $URL_PATH-$date.zip

aws s3 cp $URL_PATH-$date.$EXTENSION s3://iwoca-coho-test/$DATA_SOURCE_TYPE/

cd

rm -r $tmpdir

aws glue start-job-run --job-name $DATA_SOURCE_TYPE-csv-to-parquet --arguments "{\"--date\": \"$date\"}" --region eu-west-1
