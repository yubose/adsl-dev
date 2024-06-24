for ff in *.yml;
do
echo $ff;
gsed '/.*Style$/{N;s/\n//;}' <$ff | egrep -n '^ +style: \.[a-zA-Z]+Style +style';
done
