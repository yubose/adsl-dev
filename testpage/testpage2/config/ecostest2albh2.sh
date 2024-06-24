for ii in `cat ecostestConfigList.txt`
do
sed -e 's/testapi2.aitmed.com/albh2.aitmed.io/' <$ii >$ii.tmp
mv $ii.tmp $ii
../scripts/awsUploadConfig.sh $ii
done
