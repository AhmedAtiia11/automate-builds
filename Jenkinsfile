pipeline {
    agent any

    stages {
      //Cloning CI Repo to git the last version of the code
      stage('Clone repository') {  
        steps {
        checkout scm
    }
      }
      // Build  React Dockerfile and Rename it with the Dockerhub-reg Account name and Add the commmit number as tag name 
      stage('Test and Build React Image') {
         steps {       
         script {  
                    // env.GIT_COMMIT_REV = sh (script: 'git log -n 1 --pretty=format:"%h"', returnStdout: true)
                    sh '''
                          docker build -t hello-world-app .
                       '''   
                  }
              }                           
     }

     // push Docker Images to the registry with the modified name 
    stage('Deploy Image') {
      steps{
        script {
            sh 'docker run  hello-world-app'
          }
        }
      }
    }     
  }


