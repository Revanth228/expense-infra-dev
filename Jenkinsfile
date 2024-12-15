pipeline {
    agent {
        label 'AGENT-1'
    }
    stages {
        stage('Init') {
            steps {
                sh """
                cd 01-vpc
                terraform init reconfigure
                """
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