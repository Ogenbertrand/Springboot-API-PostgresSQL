pipeline {
    agent any

    environment {
        DATABASE_URL = "jdbc:postgresql://localhost:5432/demo"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    sh './gradlew clean build'
                }
            }
        }
    }
}
