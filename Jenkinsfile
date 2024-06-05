pipeline {
    agent {
        docker {
            image 'lb2idocker/djra_project:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        WORKSPACE_DIR = "/c/data/jenkins_home/workspace/JenkinsDockerRestAssuredPipelineTest"
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
                    sh 'docker-compose -f /c/data/jenkins_home/workspace/JenkinsDockerRestAssuredPipelineTest/docker-compose.yml up --build -d'
                    sleep 20  
                }
            }
        }

        stage('Run Rest-Assured Tests') {
            steps {
                script {
                    sh 'docker-compose -f /c/data/jenkins_home/workspace/JenkinsDockerRestAssuredPipelineTest/docker-compose.yml run rest-assured-tests'
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'docker-compose -f /c/data/jenkins_home/workspace/JenkinsDockerRestAssuredPipelineTest/docker-compose.yml down'
            }
        }
    }
}
