#!/bin/bash

set -e

tmpdir=$(mktemp -d)

cd $tmpdir

wget http://download.companieshouse.gov.uk/$URL_PATH-$DATE.zip

unzip $URL_PATH-$DATE.zip

aws s3 cp $URL_PATH-$DATE.$EXTENSION s3://iwoca-coho-test//

cd

rm -r $tmpdir

aws glue start-job-run --job-name $DATA_SOURCE_TYPE-csv-to-parquet --arguments "{\"--date\": \"$DATE\"}" --region eu-west-1