pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub'    // ID of your DockerHub credentials in Jenkins
        DOCKERHUB_USERNAME = 'priyanshugupta419'
        IMAGE_NAME = 'priyanshugupta419/simple-node-app'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKERHUB_CREDENTIALS}") {
                        docker.image("${IMAGE_NAME}").push('latest')
                    }
                }
            }
        }
    }
}
