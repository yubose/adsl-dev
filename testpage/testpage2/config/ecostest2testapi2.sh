for ii in `grep -l ecostest *.yml`
do
sed -e 's/ecostest/testapi2/' <$ii >$ii.tmp
mv $ii.tmp $ii
../scripts/awsUploadConfig.sh $ii
echo $ii >>ecostestConfigList.txt
done
