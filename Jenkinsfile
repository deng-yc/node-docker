podTemplate(label: 'jnlp-slave', 
    containers: [
        containerTemplate(
            name: 'jnlp',
            image: 'dengyc/jnlp-slave'
        )        
    ]
    ,volumes: [
        hostPathVolume(hostPath: '/usr/bin/docker', mountPath: '/bin/docker'),
        hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock'),
    ]
){
    node ('jnlp-slave') {        
        stage('获取代码') {
            git url: 'https://github.com/deng-yc/node-docker.git' , branch: 'master'
        }        
        stage('编译程序') {
            sh """
            registry="192.168.31.240:5000"
            declare -A dic
            dic=([app]="./app" [api]="./api")
            #登录docker仓库,如果需要
            #docker login --username admin --password admin localhub.online
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
            """
        }
    }
}

podTemplate(label:'hicoin-web',
    containers:[
        containerTemplate(
            name: 'hiconin-web-api',
            image:'192.168.31.240:5000/hicoin-web-api:v1.${BUILD_NUMBER}',
            ttyEnabled: true,
            envVars: [
                envVar(key: 'PORT', value: '3000'),
            ],
            ports: [portMapping(containerPort: 3000)]
        ),
        containerTemplate(
            name: 'hiconin-web-app',
            image:'192.168.31.240:5000/hicoin-web-app:v1.${BUILD_NUMBER}',
            ttyEnabled: true,
            envVars: [
                envVar(key: 'PORT', value: '3000'),
            ],
            ports: [portMapping(containerPort: 3000)]
        ),
    ]
){
    node("hicoin-web"){
        stage('Run') {
            container('hiconin-web-api') {
                sh 'echo running hiconin-web-api'
            }
            container('hiconin-web-app') {
                sh 'echo running hiconin-web-app'
            }
        }

    }
}
