#!/bin/bash
# set -x
s3LocalHome="${HOME}/aitmed/awss3"
s3BucketName="public.aitmed.com"
s3Path="s3://"${s3BucketName}"/cadl"
s3FolderBase=${s3LocalHome}/${s3BucketName}"/cadl"
appFolder="aitcom1.1"
if [ ! -z $1 ]
then
    appFolder=$1
fi
currPath=`pwd`
logName=${appFolder}"-"`basename $currPath`
s3Folder="${s3FolderBase}/${appFolder}"

if [ ! -d $s3Folder ]
then
    echo $s3Folder not exist
    mkdir -p $s3Folder
    (cd $s3Folder; aws s3 sync ${s3Path}/${appFolder}/ .)
fi

rm -f lineChange.log
totalChg=0
totalPage=0
totalPageChg=0
totalLine=0
totalNewPage=0
for ff in *.yml;
do
    if [ -f $ff ];
    then
        fileLines=`wc -l $ff | awk '{print $1}'`
        # -e output an ed script
        tgtFile=${s3Folder}/${ff}
        if [ -f $tgtFile ];
        then
            lineChanges=`diff --ignore-all-space $ff $tgtFile | wc | awk '{print $1}'`
            if [ "$lineChanges" -gt "0" ]
            then
                totalChg=`expr $lineChanges + $totalChg`
                echo $lineChanges $ff >>lineChange.log
                (( totalPageChg+=1 ))
            fi
        else
            echo $fileLines $ff '(new)' >>lineChange.log
            let totalNewPage+=1
        fi
        (( totalPage+=1 ))
        (( totalLine+=$fileLines ))
    fi;
done
totalChgRate=`echo 'scale=2;' $totalChg'*100/'$totalLine | bc`
echo $totalChg lines of $totalPageChg pages as $totalChgRate' percent of total lines have been changed' > ${logName}.log
echo $totalLine " total lines;" $totalPage " pages;" $totalNewPage " new pages;" >> ${logName}.log
echo "===============================" >> ${logName}.log

sort -nr <lineChange.log >> ${logName}.log

# generate detail report

cnt=0
while IFS= read -r line
do
  echo "$line"
  if [ "$cnt" -gt "3" ]
  then
    ff=`echo $line | awk '{print $2}'`
    tgtFile=${s3Folder}/${ff}
    if [ -f $tgtFile ];
    then
        diff --ignore-all-space $ff ${s3Folder}/${ff}
#    else
#        cat $ff
    fi
  fi
  (( cnt+=1 ))
done < ${logName}.log > ${logName}Detail.log
cat ${logName}.log
