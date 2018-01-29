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

        stage("发布到k8s"){
            kubernetesDeploy(
                credentialsType: 'Text',
                textCredentials: [
                    serverUrl: 'https://192.168.31.240:6443',
                    certificateAuthorityData: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNE1ERXlPVEEyTVRrek1Wb1hEVEk0TURFeU56QTJNVGt6TVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTUEyCmNwcDlRZUlFWDRpdkI3N29jODJNNzRyMkdpeGx3cUtwVjc2RGs1NjBTNWE1TGYxV1RMd0R1eCtzVU45OWFldUoKaHZPcmFaS09tY1JQV0ZDSzk0VFRvUE1rQk1VbUgyckI3Z0xhUzV2dXdRcXA5WTNMVElJRUNZVWhwZmZ2NkRmUQpodXhqOWpHRGFaem00czBpMjYrNldzL0dVYUM4R1BKWjROUW9oM3dFdWRvMzRNZzRObjJ0c0NWRWpvRCtRSjJiCkdBaitwd3djalBuSTVIZkpFcVBKbDJiWnVXOU9Ka2Q2ZXJ6TU5ELzVqUkJjSTlmN0pFZkhoZEVRNldWNURDQkcKNDZ4ekE2UlcvTzUrZmJjdUR2UHQ5QUNNK0MyTm9GaHpNckRnSk5TeUhMc3M0YTkwWVBGTDlQTlFzdkZkajBoVgozTzhFUEJYbjZoWXUvU2U3Q3Q4Q0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFMdENacnpRQm1oZFE0N1RuVHNOQ0drUnliWFUKY3NQbkxzTHd2b1A1SFVmS2hIeWtBNVdKckZNc2ZiSElqd1BsMVFCTkliWTJlNWJSTDF6SWc3TjV3VUMxUjVtawpLcDJOZGtrTVl2a1p2K09KRUdlTWxDZmQ4amp0ajd0a2ExNE83a2NTMWtQUUFXWGluaFpnMUdNbmUvUGxjVmNpCkxiSEZyVmpLeWxVc29Va28yNmM5Y3BkeFpFZmh3QzdzRlYxUjgzVzFWMUZuc0Q1MSt3K0l1NFNSQW5zdTRxVngKa0VwMTBLRWRBZWF1YVo3dVA2V2FSeGdqdit1TDdacERvU05hcFV0TmZNVHgrcDZieTY3UnFicVZWcXFNajd4QgpMdlhvZDNoU3RkZExvUXczU2RVVCsyTGROZGQ1VktoSjNyeWxIYUpnTHFIcFdjVFNZWnlaU3VNbG5pMD0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=',
                    clientCertificateData: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNE1ERXlPVEEyTVRrek1Wb1hEVEk0TURFeU56QTJNVGt6TVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTUEyCmNwcDlRZUlFWDRpdkI3N29jODJNNzRyMkdpeGx3cUtwVjc2RGs1NjBTNWE1TGYxV1RMd0R1eCtzVU45OWFldUoKaHZPcmFaS09tY1JQV0ZDSzk0VFRvUE1rQk1VbUgyckI3Z0xhUzV2dXdRcXA5WTNMVElJRUNZVWhwZmZ2NkRmUQpodXhqOWpHRGFaem00czBpMjYrNldzL0dVYUM4R1BKWjROUW9oM3dFdWRvMzRNZzRObjJ0c0NWRWpvRCtRSjJiCkdBaitwd3djalBuSTVIZkpFcVBKbDJiWnVXOU9Ka2Q2ZXJ6TU5ELzVqUkJjSTlmN0pFZkhoZEVRNldWNURDQkcKNDZ4ekE2UlcvTzUrZmJjdUR2UHQ5QUNNK0MyTm9GaHpNckRnSk5TeUhMc3M0YTkwWVBGTDlQTlFzdkZkajBoVgozTzhFUEJYbjZoWXUvU2U3Q3Q4Q0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFMdENacnpRQm1oZFE0N1RuVHNOQ0drUnliWFUKY3NQbkxzTHd2b1A1SFVmS2hIeWtBNVdKckZNc2ZiSElqd1BsMVFCTkliWTJlNWJSTDF6SWc3TjV3VUMxUjVtawpLcDJOZGtrTVl2a1p2K09KRUdlTWxDZmQ4amp0ajd0a2ExNE83a2NTMWtQUUFXWGluaFpnMUdNbmUvUGxjVmNpCkxiSEZyVmpLeWxVc29Va28yNmM5Y3BkeFpFZmh3QzdzRlYxUjgzVzFWMUZuc0Q1MSt3K0l1NFNSQW5zdTRxVngKa0VwMTBLRWRBZWF1YVo3dVA2V2FSeGdqdit1TDdacERvU05hcFV0TmZNVHgrcDZieTY3UnFicVZWcXFNajd4QgpMdlhvZDNoU3RkZExvUXczU2RVVCsyTGROZGQ1VktoSjNyeWxIYUpnTHFIcFdjVFNZWnlaU3VNbG5pMD0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=',
                    clientKeyData: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNE1ERXlPVEEyTVRrek1Wb1hEVEk0TURFeU56QTJNVGt6TVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTUEyCmNwcDlRZUlFWDRpdkI3N29jODJNNzRyMkdpeGx3cUtwVjc2RGs1NjBTNWE1TGYxV1RMd0R1eCtzVU45OWFldUoKaHZPcmFaS09tY1JQV0ZDSzk0VFRvUE1rQk1VbUgyckI3Z0xhUzV2dXdRcXA5WTNMVElJRUNZVWhwZmZ2NkRmUQpodXhqOWpHRGFaem00czBpMjYrNldzL0dVYUM4R1BKWjROUW9oM3dFdWRvMzRNZzRObjJ0c0NWRWpvRCtRSjJiCkdBaitwd3djalBuSTVIZkpFcVBKbDJiWnVXOU9Ka2Q2ZXJ6TU5ELzVqUkJjSTlmN0pFZkhoZEVRNldWNURDQkcKNDZ4ekE2UlcvTzUrZmJjdUR2UHQ5QUNNK0MyTm9GaHpNckRnSk5TeUhMc3M0YTkwWVBGTDlQTlFzdkZkajBoVgozTzhFUEJYbjZoWXUvU2U3Q3Q4Q0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFMdENacnpRQm1oZFE0N1RuVHNOQ0drUnliWFUKY3NQbkxzTHd2b1A1SFVmS2hIeWtBNVdKckZNc2ZiSElqd1BsMVFCTkliWTJlNWJSTDF6SWc3TjV3VUMxUjVtawpLcDJOZGtrTVl2a1p2K09KRUdlTWxDZmQ4amp0ajd0a2ExNE83a2NTMWtQUUFXWGluaFpnMUdNbmUvUGxjVmNpCkxiSEZyVmpLeWxVc29Va28yNmM5Y3BkeFpFZmh3QzdzRlYxUjgzVzFWMUZuc0Q1MSt3K0l1NFNSQW5zdTRxVngKa0VwMTBLRWRBZWF1YVo3dVA2V2FSeGdqdit1TDdacERvU05hcFV0TmZNVHgrcDZieTY3UnFicVZWcXFNajd4QgpMdlhvZDNoU3RkZExvUXczU2RVVCsyTGROZGQ1VktoSjNyeWxIYUpnTHFIcFdjVFNZWnlaU3VNbG5pMD0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=',
                ],
                configs:"./deploy/*.yaml",
                enableConfigSubstitution:true
            )
        }
    }
}
