pipeline {
    agent {
        label 'AGENT-1'
    }
    stages {
       stages {
        stage('Terraform Init') {
            steps {
                script {
                    // Navigate to the correct directory
                    dir('01-vpc') {
                        // Run terraform init with -reconfigure
                        sh 'terraform init -reconfigure'
                    }
                }
            }
        }
    }
        stage('Plan') {
            steps {
               echo 'This is Test stage'
            }
        }
        stage('Deploy') {
            steps {
                echo 'This is Deploy stage'
            }
        }
    }
}