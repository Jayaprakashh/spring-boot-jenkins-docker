 pipeline {
    agent any

    tools {
        maven 'Maven 3.8.2'   // Jenkins global name
        jdk 'JDK 17'          // Jenkins global name
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
                withCredentials([usernamePassword(credentialsId: 'docker-hub-login', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
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
 
