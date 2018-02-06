#!/bin/bash 

prefix="test"
declare -A dic
dic=([app]="./app")
#登录docker仓库,如果需要
#docker login --username admin --password admin localhub.online
for key in $(echo ${!dic[*]})
do
    echo "$key : ${dic[$key]}"
    echo --------------开始编译 $key----------------
    docker build -t $prefix-$key ${dic[$key]}
    echo --------------添加TAG----------------
    docker tag $prefix-$key $registry/$prefix-$key:v1.${BUILD_NUMBER}
    echo --------------推送到仓库----------------
    docker push $registry/$prefix-$key:v1.${BUILD_NUMBER}
    echo --------------删除本地镜像----------------
    docker rmi $prefix-$key
    docker rmi $registry/$prefix-$key:v1.${BUILD_NUMBER}
done
