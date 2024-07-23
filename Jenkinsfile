pipeline {
    agent any

    environment {
        DATABASE_URL = "jdbc:postgresql://postgres_db:5432/demo"
    }

    stages {
        stage('Wait for PostgreSQL') {
            steps {
                script {
                    sh 'while ! nc -z postgres_db 5432; do sleep 1; done'
                }
            }
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

