pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK'
    }

    stages {
        stage('Build') {
            steps {
                dir('java') {
                    bat 'mvn clean package'
                }
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                copyArtifacts(
                    projectName: env.JOB_NAME,
                    selector: lastSuccessful(),
                    filter: 'java/target/java.war',
                    target: 'C:\appache\apache-tomcat-9.0.115\webapps'
                )
            }
        }
    }
}
