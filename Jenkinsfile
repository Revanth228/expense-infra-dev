pipeline {
    agent {
        label 'AGENT-1'
    }
    options{
        ansiColor('xterm')
    }

    parameters {
        
        choice(name: 'action', choices: ['plan', 'apply', 'destroy'], description: 'Pick something')
    }

    stages {
        stage('Init') {
            
            steps {
                sh """
                
                 cd 01-vpc
                 terraform init -reconfigure

                """
            }
        }
        stage('Plan') {

            when{
                expression{
                    params.action == 'plan'
                }
            }
            steps {
               sh """
                 
                 cd 01-vpc
                 terraform plan 

                """
            }
        }
        stage('Deploy') {
            expression{
                    params.action == 'apply'
                }
            input{
                message "Should we continue??"
                ok "Yes, we should.."
            }
            steps {
                sh """
                 
                 cd 01-vpc
                 terraform apply -auto-approve

                """
            }
        }

        stage('Destroy') {
            expression{
                    params.action == 'destroy'
                }
            input{
                message "Should we continue??"
                ok "Yes, we should.."
            }
            steps {
                sh """
                 
                 cd 01-vpc
                 terraform destroy -auto-approve

                """
            }
        }
       
    }

post {
    always {
       
          deleteDir()
        
    }
}


    
}
