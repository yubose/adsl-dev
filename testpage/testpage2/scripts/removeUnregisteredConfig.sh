#!/bin/bash
for ii in *.yml
do
HAVE=`grep ${ii} ./config/appRegistry.txt`
if [ -z $HAVE ]
then
echo $ii;rm $ii
fi
done

