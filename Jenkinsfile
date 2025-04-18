pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'amazon-app'
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
                // Adjust WAR path if it's different
                sh 'cp Amazon/target/*.war Amazon.war'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                docker rm -f amazon-container || true
                docker run -d --name amazon-container -p 8900:8080 ${DOCKER_IMAGE}
                '''
            }
        }
    }
}

