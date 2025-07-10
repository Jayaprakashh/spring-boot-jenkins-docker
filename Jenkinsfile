 pipeline {
    agent any

    tools {
        maven 'Maven 3.8.2'
        jdk 'JDK 17'
    }

    environment {
        IMAGE_NAME = 'spring-boot-jenkins-docker'
        DOCKER_HUB_USERNAME = 'jayaprakash461'
        DOCKER_IMAGE = "${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Jayaprakashh/spring-boot-jenkins-docker.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
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

        stage('Cleanup') {
            steps {
                sh 'docker rmi $DOCKER_IMAGE || true'
            }
        }
    }
}
 } 
