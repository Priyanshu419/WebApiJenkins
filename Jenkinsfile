pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        DOCKERHUB_USERNAME = "${DOCKERHUB_CREDENTIALS_USR}"
        IMAGE_NAME = 'simple-node-app'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKERHUB_USERNAME%/%IMAGE_NAME%:latest ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                bat "echo %DOCKERHUB_CREDENTIALS_PSW% | docker login -u %DOCKERHUB_USERNAME% --password-stdin"
            }
        }

        stage('Push Docker Image') {
            steps {
                bat "docker push %DOCKERHUB_USERNAME%/%IMAGE_NAME%:latest"
            }
        }
    }

    post {
        success {
            echo ' Docker image built and pushed successfully!'
        }
        failure {
            echo ' Pipeline failed.'
        }
    }
}
