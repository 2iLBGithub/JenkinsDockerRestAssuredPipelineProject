node {
    stage('Checkout') {
        checkout scm
    }

    dockerNode(
        image: 'lb2idocker/djra_project:latest',
        args: '-v /var/run/docker.sock:/var/run/docker.sock'
    ) {
        withEnv(["WORKSPACE_DIR=${pwd()}"]) {
            stage('Build and Deploy with Docker Compose') {
                steps {
                    script {
                        sh 'docker-compose -f $WORKSPACE_DIR/docker-compose.yml up --build -d'
                        sleep 60  
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
    }
}

post {
    always {
        dockerNode(
            image: 'lb2idocker/djra_project:latest',
            args: '-v /var/run/docker.sock:/var/run/docker.sock'
        ) {
            withEnv(["WORKSPACE_DIR=${pwd()}"]) {
                script {
                    sh 'docker-compose -f $WORKSPACE_DIR/docker-compose.yml down'
                }
            }
        }
    }
}
