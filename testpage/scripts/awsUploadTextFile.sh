#!/bin/bash
aws s3 cp $1 $2 --content-type text/plain
