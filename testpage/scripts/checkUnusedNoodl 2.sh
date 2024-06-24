#!/bin/bash
for ff in *_en.yml
do
pageName=${ff%_en.yml};
#echo $pageName
inPageNames=`grep -l "${pageName}" *_en.yml | grep -v "^${pageName}"`
#echo $inPageNames
if [ -z "${inPageNames}" ]
then
echo $pageName is not in use.
fi
# read RR
done
