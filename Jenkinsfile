pipeline {
    agent any

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
               
                // sh 'ant build'   --build using Ant
            }
        }
    }
    
    post {
        failure {
            emailext(
                to: 'developer1@example.com developer2@example.com',
                subject: "Build Failed: ${currentBuild.fullDisplayName}",
                body: "The build has failed. Please check the Jenkins console output for more details."
            )
        }
    }
}
