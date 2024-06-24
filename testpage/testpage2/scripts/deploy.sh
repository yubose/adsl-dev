#!/bin/bash
if [ -z $1 ]
then
    echo 'Usage: deploy.sh subdomain_name'
    exit 1
fi
echo "deploying for:" $1
subdomain=$1
../scripts/awsUploadConfig.sh   ${subdomain}/${subdomain}.yml    s3://public.aitmed.com/config/
../scripts/awsUploadTextFile.sh ${subdomain}/HomePageUrl_en.yml  s3://public.aitmed.com/noodl/clients/${subdomain}/
../scripts/awsUploadImage.sh    ${subdomain}/assets/mLogo.png    s3://public.aitmed.com/noodl/clients/${subdomain}/assets/
