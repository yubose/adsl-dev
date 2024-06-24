#!/bin/bash
aws s3 sync . s3://public.aitmed.com/cadl/$1
gittag=$1
git tag -a $gittag -m $0
git push origin $gittag
