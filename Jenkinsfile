pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
		AWS_ACCESS_KEY_ID     = credentials('access-key-id')
      		AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
	}

	stages {

		stage('Docker Build') {

			steps {
				sh 'docker build -t akkalagopi/hello-world-python:latest .'
			}
		}

		stage('Docker Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Docker Push') {

			steps {
				sh 'docker push akkalagopi/hello-world-python:latest'
			}
		}

			
        stage('Terraform Init'){

            steps {
			  dir('terraform/') {
                              sh 'terraform init -no-color'
                              sh 'terraform apply --auto-approve'
			     }
		  }  
                         
        }

		stage('ansible playbook'){

            steps {
			  dir('ansible/') {
				
				 script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'aws-keypair', keyFileVariable: 'SSH_PRIVATE_KEY')]) {
                        sh """
                            ansible-playbook -i inventory main.yml --private-key=\$SSH_PRIVATE_KEY
                        """
                    
					}
                                                          
			     }
			  }  
                         
            }
	    }
	}
	post {
		always {
			sh 'docker logout'
		}
	}

}
