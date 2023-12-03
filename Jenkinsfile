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
                              sh 'terraform init -no-color -chdir=terrform/aws/'
                              sh 'terraform apply --auto-approve -no-color -chdir=terraform/aws/'
                        }

                }
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}
