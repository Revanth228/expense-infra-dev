pipeline {
    agent {
        label 'AGENT-1'
    }
    options{
        ansiColor('xterm')
    }

    parameters {
        
        choice(name: 'action', choices: ['apply', 'plan', 'destroy'], description: 'Pick something')
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
            steps {
               sh """
                 
                 cd 01-vpc
                 terraform plan 

                """
            }
        }
        stage('Deploy') {
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
       
    }

post {
    always {
       
          deleteDir()
        
    }
}


    
}
