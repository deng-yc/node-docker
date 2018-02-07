podTemplate(label: 'jnlp-slave', 
    name:"jnlp-slave",
    containers: [
        containerTemplate(
            name: 'jnlp',
            image: 'dengyc/jnlp-slave'
        )        
    ]
    ,volumes: [
        hostPathVolume(hostPath: '/run/torcx/bin/docker', mountPath: '/bin/docker'),
        hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock'),
    ]
){
    node('jnlp-slave') {  
        withEnv([
            'REGISTRY_API=294719045790.dkr.ecr.ap-northeast-1.amazonaws.com',
            'ROOT_DOMAIN=hicoin.io',
            'DEPLOY_ENV=AWS'
        ]){      
            stage('获取代码') {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']],
                    doGenerateSubmoduleConfigurations: false, 
                    extensions: [[                    
                        $class: 'SubmoduleOption',                      
                        disableSubmodules: false, 
                        parentCredentials: false, 
                        recursiveSubmodules: true, 
                        reference: '', 
                        trackingSubmodules: true
                    ]], 
                    submoduleCfg: [], 
                    userRemoteConfigs: [[
                        credentialsId: 'dengyc', 
                        url: 'https://github.com/deng-yc/node-docker.git'
                    ]]
                ])
            }        
            stage('编译程序') {
                docker.withRegistry("https://${REGISTRY_API}", "ecr:ap-northeast-1:hicoin-ecr") {
                    echo '------------hicoin-content------------' 
                    withAWS(credentials: 'hicoin-registry') {                        
                        def login = ecrLogin()
                        sh(login);                     }
                    docker.build("hicoin:test-app.build${BUILD_NUMBER}",'-f ./app/Dockerfile .').push()
                    //sh("chmod +x ./build.sh && ./build.sh");
                }
            }

            stage('处理yaml'){
                sh 'echo 当前环境为:$DEPLOY_ENV';
                sh 'sed -i "s/##${DEPLOY_ENV}##//g" `grep "##${DEPLOY_ENV}##" -rl deploy/`'
            }

            stage("发布到k8s"){
                kubernetesDeploy(
                    credentialsType: 'Text',
                    textCredentials: [
                        serverUrl: 'https://api-hicoincluster-k8s-loc-gvf6b7-1339319461.ap-northeast-1.elb.amazonaws.com',                        
                        certificateAuthorityData: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMwekNDQWJ1Z0F3SUJBZ0lNRlJERVZ0L1NkbDlmblUzSk1BMEdDU3FHU0liM0RRRUJDd1VBTUJVeEV6QVIKQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13SGhjTk1UZ3dNakEwTVRRMU5UVXhXaGNOTWpnd01qQTBNVFExTlRVeApXakFWTVJNd0VRWURWUVFERXdwcmRXSmxjbTVsZEdWek1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBCk1JSUJDZ0tDQVFFQW0vVjRwUDVZbWg4bUE0Tk14N1hOeGZiRnFiK0lCMzhhcU13ZUVGc1F3bFpzdmxDTHArZkcKOGsydWt1YXFadjRMNDhUUERXcTFJY3BEOCs5SnhucWMrc3N6bExOY3Y2TDU4M2dHYW13VkR2c0pyUTgxVzloRgpKd01CR0JFOW5kdjFsNGFCcm5SbXRxYnI0OWdRSk9WcXpibUZtQ1k3YkI3MEgwWHpRUkd2OVFGVEl0U09Cck9mCmErd01XbXlYWWlibFhCMDYwTDRnSWd4b1V3WmpvSmROVUlyWCtnRUExb1VNdmkzWndRMjA0TVgyTm5TWGU2RDMKWmVCTy92cmpISmlyT2IrM2tBb0JyWVVRSzBZQnJTdU9LVnY1RXFkeE41ek90VGhwZGdyTUVFMk1QMzBhdERBRgo4OG55L0JKOG4vU3RJRHptZDRuMjNZRUdHdS9OaEJhVXZRSURBUUFCb3lNd0lUQU9CZ05WSFE4QkFmOEVCQU1DCkFRWXdEd1lEVlIwVEFRSC9CQVV3QXdFQi96QU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFmMXBxczkrSnBEK24KK3pWK1JicXhDMlcxSTMzOGZiTnU3Y25NOEYxRFNibVNhWmFuNmxQZzcwVDI0REpaVmtTSTZwRnVsOGxmcUxueAplMjV2d21CaHFCd096UEZ6eFhtc1JZdTg5REF0U3F5THc1SVNtMVdFNFdQWDFrMVlLSkxld3hSMzB2TWFwTG8xCkdYTnU3UzRmVEQ0SHRQaDBFb0N4R2xkWVFMVUlvSHZzVHdqVmxpdlV1SUEyMDEyMUdkVUV4b2NkY3pvWjR4S1cKenZyajVOdEJvdVYvZGtScnFrK1JiU3JRdUJCWi9PNWJEN0NnY3JzckYvaUJoVVhic0FBUDd4Y1JKb2MxbTdOUQpoMnBocjdqY3dTemdsZ3c3MVJBcFpsRkp6WERFdXJzYWsxYVhtai9hZzdKTEo3MU1KcjNjcC9zem9lTlM2UGF6Cm9kSHBkUWVwL3c9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==',
                        clientCertificateData: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMrekNDQWVPZ0F3SUJBZ0lNRlJERVYzakprZGE3NjNFYU1BMEdDU3FHU0liM0RRRUJDd1VBTUJVeEV6QVIKQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13SGhjTk1UZ3dNakEwTVRRMU5UVTFXaGNOTWpnd01qQTBNVFExTlRVMQpXakFyTVJjd0ZRWURWUVFLRXc1emVYTjBaVzA2YldGemRHVnljekVRTUE0R0ExVUVBeE1IYTNWaVpXTm1aekNDCkFTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTXF4K1pWb0V5T29DTmFGYkc1RXFmN24Kd1E3MXgyTzJUZUZ6RmtaY2tBS2RzbS8vNE1MNElZU0t4Um9BbC8xbFZnRFJTeFRUQlo3dGxSRzM0RnJFNXZPegp2TGtIMUVST0psQkNiemIyZ2s5akU2cEcxaTV1T0RzRFZQeDIwOG5vZ0kyTlFTS1I5SERRb0hvLzdwMVFCTTlCCklZbk9HTHJ3WmozUnhETVlUTXc3Q1hQTVR6ekN6bEJ1anNhaDhzYXlCbzJqRmtQY2JiNEgxZ2htdjU1elljNGQKMDhPMDN3S1ZNV0w2V2twWWw1aVFjcTRwWS9rNGNISExyNmYzaDJCUUxLR280WTZSZjlpcmdpSWdrcUxwd2tIawpISG1FR0tRZ2t1eVcya0l0STg5UHNCVTF3aGFLcFpHWHNQdThzb2ppOTRFaHIyYnFaMk9HNE5yejJEMHJuRTBDCkF3RUFBYU0xTURNd0RnWURWUjBQQVFIL0JBUURBZ2VBTUJNR0ExVWRKUVFNTUFvR0NDc0dBUVVGQndNQ01Bd0cKQTFVZEV3RUIvd1FDTUFBd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFIR05zZEJGY0dEc3plQ0EybDNMeVMyagpFTSszbkhUaHlwb0doMUR0bEVtRmVTWW1SaEtyZDI1U3FzcmRNSzN5VUVaTVJldzFkMHllUnp0WThTT0JrNm5BCk5aRXF1c2ZhV3pQUGNNWWJ4b0RqQW9nUEtESFhrTHVnVmpzOVhHa3ZuZVZDY0pUQzFxMmtsZWhWZ2I5VFVhYkIKNG1leEJxOHZNMGowRkt0RHVIbEI0dkJRZWNremErSnlHc2tOb3VtUDRvaGJpYVU0ckxBaDFYR1FtM2JlNWttOQpqZjU3NWVQejJqbWpqcUU2SmxaRndrYVNBZXFISERzTWEyOStuMGVKNWJvK1VacGoxcGtwYStKZ0hCNTdWRC9nClZYZ25VcUU4ZkRvcEVmMXhBTXcxSDRob0FsaW9KaHNFQWxPZUZGcnE3d2oyZHM5a0lkRU1PYXB0N1RIVm5FMD0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=',
                        clientKeyData: 'LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBeXJINWxXZ1RJNmdJMW9Wc2JrU3AvdWZCRHZYSFk3Wk40WE1XUmx5UUFwMnliLy9nCnd2Z2hoSXJGR2dDWC9XVldBTkZMRk5NRm51MlZFYmZnV3NUbTg3Tzh1UWZVUkU0bVVFSnZOdmFDVDJNVHFrYlcKTG00NE93TlUvSGJUeWVpQWpZMUJJcEgwY05DZ2VqL3VuVkFFejBFaGljNFl1dkJtUGRIRU14aE16RHNKYzh4UApQTUxPVUc2T3hxSHl4cklHamFNV1E5eHR2Z2ZXQ0dhL25uTmh6aDNUdzdUZkFwVXhZdnBhU2xpWG1KQnlyaWxqCitUaHdjY3V2cC9lSFlGQXNvYWpoanBGLzJLdUNJaUNTb3VuQ1FlUWNlWVFZcENDUzdKYmFRaTBqejArd0ZUWEMKRm9xbGtaZXcrN3l5aU9MM2dTR3ZadXBuWTRiZzJ2UFlQU3VjVFFJREFRQUJBb0lCQUJXNGtzVm0vTDRTY0xnRQpYa1ZHeUd6UGl3bStYdHFabTZqd08wL1k5WG5DU20va0hNTG44amVRNDJSUThmaXVsbFBLR2VDbWFIREtodkg2CklXbTR0Z01obkxTN1dRemt6d2hFeGtRK2tHSlBmTGovbEU0dmM0a25aMEVTdnNsaFIvMWpTTHFhcDNZN2RTY0UKbU41MHg3OHAvSjBXMytHUWgzUlNlVkw4WktaeDhEdTRJanNBVk5FbVZ6YWxvenpta0MrL3VkY2tLVWJUdFRvTApMcHRSSUc4NitvY09WL2x2b2V2KzB5eHU3TEtsTjhMcVRvZXA4d0pLZzdnU3BEWURTRlBmeGNxSlRjb3VNN1F3CjBDVG8xdXUxYVVDL0ljSVMvUDFPK0Q5TnI0eWRReXhCWVNCNytqN200QWhFTTZBY3BEblJBUmwvTU5QOXF1TDgKdkVGOTE0VUNnWUVBMWdtb0NiOFBmSEtjRlIxR0x6OUh0RnMxM3dlZ28zQmFKTzlwdGgvVm1HdXJQcmNwU3dWVApYZ1dxaFNLUnNOK0VtcmR1ZlNPSStFaS91WXFFSUFQdDMxRVBMTkFlTmkrZmRkdjVaOEpyUDdUb2Y3c3BINTdzCnlNUFZsYU9EblVBcWxSZEtoYWovQW4xQzdQVjVjWS82U2FNUDdiL3k4Y0VCOW5sNEdiSkJIR2NDZ1lFQThtOE0KbmJ4Tnp2ek00b2lPc09IdW1kbDgzbFdqNnRydDRaWmVBdUR2cW9pUG0wZnQveGVnUWtPV0VaNklheGd3Szh3NQpsMmhaZEpST0RFR1pBdkw3K0VSMVZ1ZjNIeHFGZVA2NXNPSWlsY2IzSVZBQWplR2lmYldSdHY3QVVETGtoVmJFCmxWYW1ad0x3ZEFJR21paDM5VlVjc2V4Y0tlRzFVK3ZDSDZRL0VTc0NnWUVBeUVaeTJPUFJUc1pETERLZk9KaUMKdE0xZ0JCZzBCSnFkanRBQzMycThSNG4veTRoQmVEUThoTTdTZHc4WXVpTDhCblU3U3BiVWxGWW1LQ3ZuWTdtcAplL3R5TXFGdWs0OU9LMDh3K1JqZmw5WGtjNWlpYXpjZkl1Q3oydmdNc0RpWlg3WlNnZXpXNlBKaWpDMUpmS3lYCkt3NE1Xby93ZUt2NzlUQkY0KzE2cFdNQ2dZRUFzM0dwRi9QeWI5eEUxd1NYQWF3cHpPempkVHBVbXhpemJQKzgKMUVxa2UwaWJheWVCclFoUzBkbHU4ZG16UmZuZ1pmckRRaU8xMndtTy81bHFaWGx2TWVPU0t1S0YweHJ4WW83QQo2WUZvY2c2VWk2N0l5andSNXhTSEo3bEdwZFlWdWZCd2o4MVVXL2tiKy9JbjZ1RTdjWGN2Unk4WlJOTFJRYTNHCndWNzBZNE1DZ1lCNFhVWnMxS2tZYXZYOWdOSTdWYWJXVFAwUlJkelBqdFNZRWFvVE0xZ1RZNTN6TGpuTjE1ZTgKa0xpd04zSVdQWW95YWEvcjd6QWlBbTVZVS9rRTFLTUhlQVI0Q3dZL29ralNQYTlWTUtKcUk3dW8yN3BvUlpZbApkMHBEQzJYYnU1MkZLYnIwRjVKQ1RqcEhIMFpJSmdWY2s0QTZXZUhaYTNCalFwU2NGOVN3Q2c9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=',
                    ],
                    configs:"deploy/**/*.yaml",
                    enableConfigSubstitution:true
                )
            }
        }
    }
}