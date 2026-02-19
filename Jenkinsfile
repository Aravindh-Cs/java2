pipeline {
    agent any

    tools {
        jdk 'JDK'
        maven 'MAVEN'
    }

    stages {
        stage('Build WAR') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                bat 'C:/appache/apache-tomcat-9.0.115/webapps'
            }
        }
    }
}
