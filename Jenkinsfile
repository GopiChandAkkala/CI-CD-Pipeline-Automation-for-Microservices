pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
		AWS_ACCESS_KEY_ID     = credentials('access-key-id')
      		AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
	}

	stages {

		stage('Build') {

			steps {
				sh 'docker build -t akkalagopi/hello-world-python:latest .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push akkalagopi/hello-world-python:latest'
			}
		}

			
                stage('Terraform Init'){

                        steps {
			  dir('terraform/aws/') {
                              sh 'terraform init -no-color'
                              sh 'terraform apply --auto-approve'
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