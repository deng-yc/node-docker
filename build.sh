#!/bin/bash  
arr=("app" "api")

for var in ${arr[@]};  
do  
    echo --------------开始编译 $var----------------
    docker build -t hicoin-web-$var ./$var
    echo --------------添加TAG----------------
    docker tag hicoin-web-$var 192.168.31.245:5000/hicoin-web-$var:v1.${BUILD_NUMBER}
    echo --------------推送到仓库----------------
    docker push 192.168.31.245:5000/hicoin-web-$var:v1.${BUILD_NUMBER}
    echo --------------删除本地镜像----------------
    docker rmi hicoin-web-$var
    docker rmi 192.168.31.245:5000/hicoin-web-$var:v1.${BUILD_NUMBER}
done  
