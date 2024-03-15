pipeline {
    agent { 
        label 'QA'
    }

    tools {
        jdk 'jdk17'
        maven 'maven3'
    }

     stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM") {
               steps {
                   git branch: 'main', credentialsId: 'Git-Github-token', url: 'https://github.com/Devnikops/Jenkins-case-study.git'
               }
        }
         
        stage('Build') {
            steps {
                sh 'mvn clean install'
               
                // sh 'ant build'              -- build using Ant
            }
        }
    }
    
    post {
        failure {
            emailext(
                to: 'devopswithnik@gmail.com',
                subject: "Build Failed: ${currentBuild.fullDisplayName}",
                body: "This build has failed."
            )
        }
    }
}
