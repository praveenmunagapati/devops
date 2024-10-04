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
                cleanWs()
                git url: 'https://github.com/praveenmunagapati/devops.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    bat "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    // Stop and remove existing container if it exists
                    echo 'Stopping existing Flask application...'
                    bat "docker stop ${CONTAINER_NAME} || exit 0"
                    bat "docker rm ${CONTAINER_NAME} || exit 0"
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Run the Docker container
                    echo 'Running Flask application in Docker...'
                    bat "docker run -d --name ${CONTAINER_NAME} -p 5000:5000 ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Remove the Docker image if desired
            bat "docker rmi ${IMAGE_NAME} || exit 0"
        }
    }
}
