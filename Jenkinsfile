pipeline {
    agent any
    tools {
        nodejs 'NodeJS'
    }

    # credentials created with ssh
    environment {
        SSH_CREDENTIALS_ID = 'jenkinsa'
    }

    # install app dependencies
    stages {
        stage("Install Dependencies") {
            steps {
                script {
                    echo "Installing dependencies..."
                    sh 'npm install'
                }
            }
        }

        # deploy to remote server
        stage("Deploy to Remote Server") {
            steps {
                script {
                    echo "Deploying to remote server..."
                    sshagent([env.SSH_CREDENTIALS_ID]) {
                        sh '''
                        # Create new directory on the remote server
                        ssh -o StrictHostKeyChecking=no ubuntu@$PUBLIC_IP 'mkdir -p /home/ubuntu/test2/'

                        # Copy application code to the remote server
                        scp -o StrictHostKeyChecking=no -r . ubuntu@$PUBLIC_IP:/home/ubuntu/test2/

                        # SSH into the remote server for deployment tasks
                        ssh -o StrictHostKeyChecking=no ubuntu@$PUBLIC_IP << 'EOF'

                            # Navigate to the deployment directory
                            cd /home/ubuntu/test2/

                            # Install dependencies on the remote server
                            # npm install

                            # Start the application
                            nohup npm start &
                        EOF
                        '''
                    }
                }
            }
        }
    }

    #clean up workspace
    post {
        always {
            script {
                echo "Cleaning workspace..."
                cleanWs()
            }
        }
    }
}
