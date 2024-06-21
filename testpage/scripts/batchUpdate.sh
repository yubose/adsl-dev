#!/bin/bash
for ff in `egrep -l '#componentId' *.yml`
do
echo $ff
#sed -f sedcmd <$ff | sed -f sedcmd2 >tmp.txt
sed -f sedcmd4 <$ff  >tmp.txt
mv tmp.txt $ff
done
