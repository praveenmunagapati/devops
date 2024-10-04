pipeline {
    agent any

    environment {
        VENV_PATH = 'myprojectenv'
        FLASK_APP = 'myproject.py'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from a source control management system (e.g., Git)
                git url: 'https://github.com/praveenmunagapati/devops.git', branch: 'main'
            }
        }

        stage('Setup Virtual Environment') {
            steps {
                script {
                    // Check for the virtual environment, create it if it doesn't exist
                    bat "python -m venv ${VENV_PATH}"
                    // Activate the virtual environment
                    bat "call ${VENV_PATH}\\Scripts\\activate.bat"
                }
            }
        }

        stage('Install dependencies') {
            steps {
                // Install any dependencies listed in requirements.txt
                bat "call ${VENV_PATH}\\Scripts\\activate.bat && pip install -r requirements.txt"
            }
        }

        stage('Test') {
            steps {
                // Run your tests here. This is just a placeholder.
                // For example, if you had tests, you might run: pytest
                echo "Assuming tests are run here. Please replace this with actual test commands."
                // bat "call ${VENV_PATH}\\Scripts\\activate.bat && pytest"
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy your Flask app
                    // This step greatly depends on where and how you're deploying your app
                    echo 'Deploying application...'
                    // Example: bat 'copy /Y .\*.* user@your_server:/path/to/deploy'
                }
            }
        }
    }

    post {
        always {
            // Clean up after the pipeline runs
            echo 'Cleaning up...'
            bat "rmdir /S /Q ${VENV_PATH}"
        }
    }
}
