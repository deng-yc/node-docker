podTemplate(name:"jnlp-slave",
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
            sh("chmod +x ./build.sh && ./build.sh")
        }
    }
}

