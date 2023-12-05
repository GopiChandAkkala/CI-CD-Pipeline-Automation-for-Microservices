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
                    script {
			     sh 'terraform init -no-color'
                             sh 'terraform apply -auto-approve'
                            
                   }
                      
			    }
		  }  
                         
        }
        

        stage('Terraform get IP'){

            steps {
			  dir('terraform/') {
                    script {
						     def ec2PublicIp = sh(script: 'terraform output -json ec2_instance_public_ip', returnStdout: true).trim()
                    
                              withEnv(['EC2_PUBLIC_IP=' + ec2PublicIp]) {
                              echo "EC2 Public IP: ${EC2_PUBLIC_IP}"
							  }
                   }
                      
			    }
		  }  
                         
        }






		stage('ansible playbook get IP'){

            steps {
			  dir('ansible/') {
				
				 script {
                   
                        writeFile file: 'inventory.ini', text: "my-ec2 ansible_host=${env.EC2_PUBLIC_IP} ansible_user=ec2-user"
                        
                    
					
                                                          
			     }
			  }  
                         
            }
	    }

		stage('ansible play playbook'){

            steps {
			  dir('ansible/') {
				
				 script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'aws-keypair', keyFileVariable: 'SSH_PRIVATE_KEY')]) {
                        
                        sh """
                            ansible-playbook -i inventory.ini  main.yml --private-key=\$SSH_PRIVATE_KEY
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
