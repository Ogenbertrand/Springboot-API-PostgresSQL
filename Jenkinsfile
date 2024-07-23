pipeline {
    agent any

    environment {
        DATABASE_URL = "jdbc:postgresql://postgres_db:5432/demo"
    }

        stage('Build') {
            steps {
                script {
                    sh './gradlew clean build'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh './gradlew test'
                }
            }
        }
    }
}

