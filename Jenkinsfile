 pipeline {
    agent any

    tools {
        maven 'Maven 3.8.2'
        jdk 'JDK 17'
    }

    environment {
        IMAGE_NAME = 'spring-boot-jenkins-docker'
        DOCKER_HUB_USERNAME = 'jayaprakash461'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${DOCKER_TAG}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        docker.image("${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${DOCKER_TAG}").push()
                    }
                }
            }
        }
    }
}
 