pipeline {
    agent { label  "QA"}

    stages {
        stage('Hello') {
            steps {
                git branch: 'main', credentialsId: 'Git-Github-token', url: 'https://github.com/devnikops/Jenkins-case-study'
            }
        }
    }
}
