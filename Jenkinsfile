pipeline {
    agent any

    stages {
      //Cloning CI Repo to git the last version of the code
      stage('Clone repository') {  
        steps {
        checkout scm
    }
      }
      // Build Dockerfile
      stage('Build Maven Image') {
         steps {       
         script {  
                    sh '''
                          docker build -t hello-world-app .
                       '''   
                  }
              }                           
     }

     // push Docker Images to the registry with the modified name 
      stage('Run docker container') {
        steps{
          script {
            sh 'docker run  hello-world-app'
            }
          }
        }
    stage('Trigger Ansible job ') {
                steps {
                echo "triggering Ansible Job"
                build job: 'ansible_pipeline' 
        }
        }      
      }
    }     


