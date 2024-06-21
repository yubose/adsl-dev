#!/bin/bash
gittag=$1.$(grep timestamp $1 | awk '{print $2}')
echo $gittag
aws s3 cp $1 s3://public.aitmed.com/config/ --content-type text/plain --cache-control no-cache,no-store,must-revalidate --expires "60"
git tag -a $gittag -m "awsUploadConfig tag"
git push origin $gittag
