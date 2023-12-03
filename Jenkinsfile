pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
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
                              sh 'cd terraform/aws/'
                              sh 'terraform init -no-color'
                              sh 'terraform apply --auto-approve -no-color'
                        }

                }
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}
