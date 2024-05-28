pipeline {
    agent any

    environment {
        DOCKER_HOST = 'unix:///var/run/docker.sock'
    }

    stages {
        stage('Build Express Server') {
            steps {
                script {
                    docker.build('docker-express-server', 'DockerExpressServer')
                }
            }
        }

        stage('Deploy Express Server') {
            steps {
                script {
                    sh 'docker stop docker-express-server || true && docker rm docker-express-server || true'
                    sh 'docker run -d -p 3000:3000 --name docker-express-server docker-express-server'
                    sleep 10
                }
            }
        }

        stage('Build Rest-Assured Tests') {
            steps {
                script {
                    docker.build('rest-assured-tests', 'DockerRestAssuredServer')
                }
            }
        }

        stage('Run Rest-Assured Tests') {
            steps {
                script {
                    docker.image('rest-assured-tests').inside {
                        sh 'mvn test'
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'docker stop docker-express-server || true && docker rm docker-express-server || true'
            }
        }
    }
}
