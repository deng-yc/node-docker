podTemplate(label: 'jnlp-slave', 
    name:"jnlp-slave",
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

// podTemplate(label:'hicoin-web',
//     containers:[
//         containerTemplate(
//             name: 'hiconin-web-api',
//             image:'192.168.31.240:5000/hicoin-web-api:v1.'+BUILD_NUMBER,
//             ttyEnabled: true,
//             envVars: [
//                 envVar(key: 'PORT', value: '3000'),
//             ],
//             ports: [portMapping(containerPort: 3000)]
//         ),
//         containerTemplate(
//             name: 'hiconin-web-app',
//             image:'192.168.31.240:5000/hicoin-web-app:v1.'+BUILD_NUMBER,
//             ttyEnabled: true,
//             envVars: [
//                 envVar(key: 'PORT', value: '3000'),
//             ],
//             ports: [portMapping(containerPort: 3000)]
//         ),
//     ]
// ){
//     node("hicoin-web"){
//         stage('Run') {
//             container('hiconin-web-api') {
//                 sh 'echo running hiconin-web-api'
//             }
//             container('hiconin-web-app') {
//                 sh 'echo running hiconin-web-app'
//             }
//         }

//     }
// }
