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
                    echo 'Stopping existing Flask application...'
                    bat "docker stop ${CONTAINER_NAME} || exit 0"
                    bat "docker rm ${CONTAINER_NAME} || exit 0"
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    echo 'Running Flask application in Docker...'
                    bat "docker run -d --name ${CONTAINER_NAME} -p 5000:5000 ${IMAGE_NAME}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Create a temporary kubeconfig file
                    //writeFile file: 'kubeconfig', text: credentials('kubeconfig')

                    // Set the Kube config environment variable
                    env.KUBECONFIG = 'kubeconfig'

                    // Apply Kubernetes deployment and service configurations
                    echo 'Deploying to Kubernetes...'
                    bat "kubectl apply -f flask-app-deployment.yaml"
                    bat "kubectl apply -f flask-app-service.yaml"
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            bat "docker rmi ${IMAGE_NAME} || exit 0"
        }
    }
}
