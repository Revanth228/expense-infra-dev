pipeline {
    agent {
        label 'AGENT-1'
    }
    stages {
        stage('Init') {
            steps {
                echo 'This is Build'
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