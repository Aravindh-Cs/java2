
// pipeline {
//     agent any

//     tools {
//         jdk 'JDK'
//         maven 'MAVEN'
//     }

//     environment {
//         TOMCAT_HOME = "C:\\appache\\apache-tomcat-9.0.115-windows-x64\\apache-tomcat-9.0.115"
//         CATALINA_HOME = "C:\\appache\\apache-tomcat-9.0.115-windows-x64\\apache-tomcat-9.0.115"
//         WAR_NAME = "java.war"
//     }

//     stages {

//         stage('Checkout') {
//             steps {
//                 echo "Checking out code..."
//                 git branch: 'main', url: 'https://github.com/Aravindh-Cs/java2.git'
//             }
//         }

//         stage('Build WAR') {
//             steps {
//                 echo "Building WAR..."
//                 bat 'mvn clean package'
//             }
//         }

//         stage('Stop Tomcat') {
//             steps {
//                 echo "Stopping Tomcat..."
//                 bat '"%CATALINA_HOME%\\bin\\shutdown.bat"'
//                 bat 'ping 127.0.0.1 -n 6 > nul' // wait ~5 seconds
//             }
//         }

//         stage('Deploy WAR') {
//             steps {
//                 echo "Deploying WAR..."
//                 bat 'copy /Y target\\%WAR_NAME% "%TOMCAT_HOME%\\webapps\\"'
//             }
//         }

//         stage('Start Tomcat') {
//             steps {
//                 echo "Starting Tomcat..."
//                 bat '"%CATALINA_HOME%\\bin\\startup.bat"'
//             }
//         }
//     }

//     post {
//         success {
//             echo "Deployment complete! Access your app at http://localhost:8081/java/index.jsp"
//         }
//         failure {
//             echo "Deployment failed! Check WAR name, paths, or Tomcat logs."
//         }
//     }
// }

pipeline {
    agent any

    environment {
        TOMCAT_HOME = "C:\\appache\\apache-tomcat-9.0.115-windows-x64\\apache-tomcat-9.0.115"
        WAR_NAME = "java.war"
    }

    stages {
        stage('Build WAR') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Deploy WAR') {
            steps {
                echo "Deploying WAR..."
                bat """
                copy /Y target\\${WAR_NAME} ${TOMCAT_HOME}\\webapps\\
                """
            }
        }

        stage('Start Tomcat') {
            steps {
                echo "Starting Tomcat..."
                bat """
                set CATALINA_HOME=${TOMCAT_HOME}
                start "" "${TOMCAT_HOME}\\bin\\catalina.bat" run
                """
            }
        }
    }

    post {
        success {
            echo "Deployment complete! Access your app at http://localhost:8081/java/index.jsp"
        }
        failure {
            echo "Deployment failed!"
        }
    }
}
