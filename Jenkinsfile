pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'amazon-app'
        LOGS_DIR = '/usr/local/tomcat/logs' // Tomcat's default logs dir
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

        stage('Run Docker Container') {
            steps {
                sh '''
                docker rm -f amazon-container || true
                docker volume create amazon-tomcat-logs || true
                docker run -d --name amazon-container \
                    -p 8900:8080 \
                    -v amazon-tomcat-logs:/usr/local/tomcat/logs \
                    ${DOCKER_IMAGE}
                '''
            }
        }
    }
}

