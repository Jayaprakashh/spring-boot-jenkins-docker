pipeline {
    agent any

    tools {
        maven 'Maven 3.8.2'   // ✅ Must match your Jenkins global Maven name
        jdk 'JDK 17'          // ✅ Must match your Jenkins global JDK name
    }

    environment {
        IMAGE_NAME = 'spring-boot-jenkins-docker'
        DOCKER_HUB_USERNAME = 'jayaprakashjp' // ✅ Your DockerHub username
        DOCKER_IMAGE = "${DOCKER_HUB_USERNAME}/${IMAGE_NAME}"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/jayaprakashjp/spring-boot-jenkins-docker.git' // ✅ Replace with your actual repo URL
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://index.docker.io/v1/']) {
                    script {
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                // Stop and remove existing container if already running
                sh '''
                docker stop spring-app || true
                docker rm spring-app || true
                docker run -d -p 9006:8080 --name spring-app ${DOCKER_IMAGE}:latest
                '''
            }
        }
    }

    post {
        always {
            echo 'Build completed.'
        }
    }
}
