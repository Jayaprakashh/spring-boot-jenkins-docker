pipeline {
    agent any

    tools {
        maven 'Maven 3.8.2'   // ✅ Must match your Jenkins global Maven name
        jdk 'JDK 17'          // ✅ Must match your Jenkins global JDK name
    }

    environment {
        IMAGE_NAME = 'spring-boot-jenkins-docker'
        DOCKER_HUB_USERNAME = 'jayaprakash461' // ✅ Your DockerHub username
        DOCKER_TAG = 'latest'
      
    }

  stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
  
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/jayaprakashjp/spring-boot-jenkins-docker.git' // ✅ Replace with your actual repo URL
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

         
    post {
        always {
            echo 'Build completed.'
        }
    }
}
