pipeline {
    agent {
        label 'AGENT-1'
    }
    options{
        ansiColor('xterm')
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
                 terraform plan -auto-approve

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
                 terraform plan -auto-approve

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
