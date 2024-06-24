#/bin/bash
if [ -z $1 ]
then
    echo 'Usage: clone.sh subdomain_name'
    exit 1
fi

cloneFrom=$1
if [ -z ${cloneFrom} ]
then
    echo "Usage: clone.sh from to"
fi

subdomain=$2
if [ -z ${subdomain} ]
then
    cloneFrom='aitcomTemp'
    subdomain=$1
fi
echo "Cloning from " ${cloneFrom} " for " ${subdomain} 

if [ -d ${subdomain} ]
then
    echo update for ${subdomain}
else
    mkdir $subdomain
fi

hostLogoFile=logos/${subdomain}Logo.png
if [ -f $hostLogoFile ]
then
    echo $hostLogoFile
else
    echo "File not found: " $hostLogoFile
    exit
fi

if [ ! -d "${subdomain}/assets/" ]; then
  mkdir -p "${subdomain}/assets/"
fi
cp -p $hostLogoFile ${subdomain}/assets/mLogo.png
sed -e "s/${cloneFrom}/$subdomain/" <${cloneFrom}/${cloneFrom}.yml > ${subdomain}/${subdomain}.yml

hostUrlFile=hosts/${subdomain}.url
if [ -f $hostUrlFile ]
then
   echo -n "HomePageUrl: " > ${subdomain}/HomePageUrl_en.yml
   cat $hostUrlFile >> ${subdomain}/HomePageUrl_en.yml
else
   echo "File not found: " $hostUrlFile
   cp ${cloneFrom}/HomePageUrl_en.yml ${subdomain}/
fi
