#!/bin/bash
#upload single file or files in a single directory to s3
# set -x
getContentType() {
  echo File $1
  fileSuffix=${1##*.}
  echo Suffix $fileSuffix
  case ${fileSuffix} in
    "yml") contentType="text/plain"
       ;;
    "png") contentType="image/png"
       ;;
    "mp4") contentType="video/mp4"
       ;;
    *) contentType=""
       echo "unknown file suffix";
       ;;
  esac
}
awss3upload() {
  getContentType $1
  if [ "$contentType" != "" ]
  then
     echo $1 $contentType
     aws s3 cp $1 s3://public.aitmed.com/cadl/${DESTINATION_FOLDER}/ --content-type $contentType
  else
     echo $1 "unknown type"
     aws s3 cp $1 s3://public.aitmed.com/cadl/${DESTINATION_FOLDER}/
  fi
}

DIR_OR_FILE_NAME=$1
DESTINATION_FOLDER=$2
if [ -d ${DIR_OR_FILE_NAME} ]
then
    for ff in `ls ${DIR_OR_FILE_NAME}`
    do
        awss3upload ${DIR_OR_FILE_NAME}/$ff
    done
else
    awss3upload $DIR_OR_FILE_NAME
fi
