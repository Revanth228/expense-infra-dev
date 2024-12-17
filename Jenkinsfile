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
                 aws s3 ls
                 cd 01-vpc
                 terraform init -reconfigure

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
