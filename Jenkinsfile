pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'amazon-app'
        ACR_NAME = 'dockeranup.azurecr.io'
        ACR_IMAGE = 'dockeranup.azurecr.io/amazon-app:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'your-git-creds-id', url: 'https://github.com/dev-anupsa/Amazon.git'
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn -f Amazon/pom.xml clean install'
            }
        }

        stage('Copy WAR') {
            steps {
                sh 'cp Amazon/Amazon-Web/target/Amazon.war Amazon.war'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Tag Image for ACR') {
            steps {
                sh 'docker tag ${DOCKER_IMAGE} ${ACR_IMAGE}'
            }
        }

        stage('Login to ACR') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'acr-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'echo $PASSWORD | docker login ${ACR_NAME} -u $USERNAME --password-stdin'
                }
            }
        }

        stage('Push to ACR') {
            steps {
                sh 'docker push ${ACR_IMAGE}'
            }
        }

        stage('Run Docker Container (Optional)') {
            steps {
                sh '''
                docker rm -f amazon-container || true
                docker volume create amazon-tomcat-logs || true
                docker run -d --name amazon-container -p 8900:8080 \
                    -v amazon-tomcat-logs:/usr/local/tomcat/logs \
                    ${ACR_IMAGE}
                '''
            }
        }
    }
}

