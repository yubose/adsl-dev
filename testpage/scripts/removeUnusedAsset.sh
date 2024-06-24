#!/bin/bash
for im in *;
do 
usage=`grep ${im%.*} ../*.yml`;
if [ "$usage" == "" ];
then
    echo "删除 $im";
    rm "${im}"
else echo "2";
fi;
done
