pipeline {
    agent {
        docker {
            image 'lb2idocker/djra_project:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/workspace'
        }
    }

    environment {
        WORKSPACE_DIR = '/workspace'
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
                    sh 'docker-compose -f $WORKSPACE_DIR/docker-compose.yml up --build -d'
                    sleep 20  
                }
            }
        }

        stage('Run Rest-Assured Tests') {
            steps {
                script {
                    sh 'docker-compose -f $WORKSPACE_DIR/docker-compose.yml run rest-assured-tests'
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'docker-compose -f $WORKSPACE_DIR/docker-compose.yml down'
            }
        }
    }
}
