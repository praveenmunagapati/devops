pipeline {
    agent any

    environment {
        VENV_PATH = 'myprojectenv'
        FLASK_APP = 'myproject.py'
        IMAGE_NAME = 'my_flask_app'
        CONTAINER_NAME = 'flask_app_container'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/praveenmunagapati/devops.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    // Stop and remove existing container if it exists
                    echo 'Stopping existing Flask application...'
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Run the Docker container
                    // Adjust ports and environment variables as needed
                    echo 'Running Flask application in Docker...'
                    sh "docker run -d --name ${CONTAINER_NAME} -p 5000:5000 ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Optional: remove the Docker image if desired
            sh "docker rmi ${IMAGE_NAME} || true"
        }
    }
}
