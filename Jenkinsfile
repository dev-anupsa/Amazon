pipeline {
  agent any

  environment {
    IMAGE_NAME = "amazon-app"
    DOCKERHUB_USER = "anup8dev"
  }

  stages {
    stage('Checkout') {
      steps {
        git credentialsId: 'your-cred-id', url: 'https://github.com/dev-anupsa/Amazon'
      }
    }

    stage('Build') {
      steps {
        sh 'mvn clean install'
      }
    }

    stage('Docker Build & Push') {
      steps {
        script {
          docker.build("${IMAGE_NAME}:latest")
          docker.withRegistry('', 'dockerhub-credentials-id') {
            docker.image("${IMAGE_NAME}:latest").push('latest')
          }
        }
      }
    }

    stage('Terraform Infra') {
      steps {
        dir('terraform-directory') {
          sh 'terraform init'
          sh 'terraform plan'
          // sh 'terraform apply -auto-approve'
        }
      }
    }

    stage('Deploy with Ansible') {
      steps {
        dir('ansible') {
          sh 'ansible-playbook deploy.yml'
        }
      }
    }
  }

  parameters {
    booleanParam(name: 'APPLY_CHANGES', defaultValue: false, description: 'Apply Terraform changes?')
  }

  post {
    failure {
      mail to: 'anupsa.cs@gmail.com',
           subject: "Build Failed: ${env.JOB_NAME}",
           body: "Check the Jenkins logs for ${env.BUILD_URL}"
    }
  }
}

