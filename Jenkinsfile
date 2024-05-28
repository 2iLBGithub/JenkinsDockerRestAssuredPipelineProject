pipeline {
    agent any

    environment {
        DOCKER_HOST = 'unix:///var/run/docker.sock'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build and Deploy with Docker Compose') {
            steps {
                script {
                    sh 'docker-compose -f docker-compose.yml up --build -d'
                    sleep 20  
                }
            }
        }

        stage('Run Rest-Assured Tests') {
            steps {
                script {
                    sh 'docker-compose -f docker-compose.yml run rest-assured-tests'
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'docker-compose -f docker-compose.yml down'
            }
        }
    }
}
