pipeline {
    agent any

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

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t amazon-app .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 8080:8080 --name amazon amazon-app'
            }
        }
    }
}

