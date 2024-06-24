#!/bin/bash
# @author chenchen.xu
# @date 2021/9/4

lastNumber=0
nextVersionNumber=0
configName=$1
# get the folder name in the server
function getFoldername(){
    # serverFolderName='admin'
    if [[ $configName == "admind2" ]] || [[ $configName == "admind" ]] || [[ $configName == "admin" ]];then
        projectName="admin"
        if [ $configName == "admind2" ];then
            serverFolderName="admindd"
        else
            serverFolderName=$configName
        fi
    elif [[ $configName == "prod2" ]] || [[ $configName == "prod" ]] || [[ $configName == "provider" ]];then
        projectName="provider"
        if [ $configName == "prod2" ];then
            serverFolderName="prodd"
        else
            serverFolderName=$configName
        fi
    elif [[ $configName == "patd2" ]] || [[ $configName == "patd" ]] || [[ $configName == "patient" ]];then
        projectName="patient"
        if [ $configName == "patd2" ];then
            serverFolderName="patdd"
        else
            serverFolderName=$configName
        fi
    elif [[ $configName == "searchd2" ]] || [[ $configName == "searchd" ]] || [[ $configName == "search" ]];then
        projectName="search"
        if [ $configName == "searchd2" ];then
            serverFolderName="searchdd"
        else
            serverFolderName=$configName
        fi
    else
        echo "the project of $configName can't be fround"
        exit 1
    fi
}
# https://www.cnblogs.com/cobbliu/p/6045412.html
function currentVersion(){
    currentVersionNumber=0
    # yaml file
    cat ../config/$configName.yml>a.out
    while read line
    do
        # find the version number , which line start with "stable:"
        if [ "$(echo $line | grep "stable:")" != "" ];then
            # split string with ": ", to get version number 
            currentVersion=`echo "$line"|awk -F ": " '{print $2}'`
            break
        fi
    done < a.out
    currentVersionNumber=$currentVersion
    rm -f a.out    
}
getFoldername
currentVersion

echo "projectName: $projectName"
echo "serverFolderName: $serverFolderName"

# already get the current version , update version: +0.01 ,if endWith "9"+0.02
lastNumber=`echo ${currentVersionNumber: -1}`

if [ $lastNumber -eq 9 ];then
    nextVersionNumber=`echo "$currentVersionNumber + 0.02" | bc`
else
    nextVersionNumber=`echo "$currentVersionNumber + 0.01" | bc`
fi

echo -e "\033[31mcurrentVersionNumber:\033[0m \033[37;36m$currentVersionNumber\033[0m"
echo -e "\033[31mupdateVersion:\033[0m \033[37;36m$nextVersionNumber\033[0m"
echo -e "\033[31mupload:\033[0m \033[37;36m$configName.yml to s3://public.aitmed.com/config/$configName.yml\033[0m"
echo -e "\033[31mupload:\033[0m \033[37;36m$projectName to s3://public.aitmed.com/cadl/$serverFolderName$nextVersionNumber/\033[0m"

# # # change version number in config file
sed -i "" "s/${currentVersionNumber}/${nextVersionNumber}/g" ../config/$configName.yml

# # # upload yaml to cdn
aws s3 sync ../$projectName/ s3://public.aitmed.com/cadl/$serverFolderName$nextVersionNumber/
# # upload config file to cdn
./awsUploadConfig.sh ../config/$configName.yml

git pull
git add .
git commit -a -m "update config file, upload $configName new version: ${nextVersionNumber}"
git push