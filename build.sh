#!/bin/bash 

registry="hicoin-registry:5000"

declare -A dic
dic=([app]="./app" [api]="./api")

for key in $(echo ${!dic[*]})
do
    echo "$key : ${dic[$key]}"
    echo --------------开始编译 $key----------------
    docker build -t hicoin-web-$key ${dic[$key]}
    echo --------------添加TAG----------------
    docker tag hicoin-web-$key $registry/hicoin-web-$key:v1.${BUILD_NUMBER}
    echo --------------推送到仓库----------------
    docker push $registry/hicoin-web-$key:v1.${BUILD_NUMBER}
    echo --------------删除本地镜像----------------
    docker rmi hicoin-web-$key
    docker rmi $registry/hicoin-web-$key:v1.${BUILD_NUMBER}
done
