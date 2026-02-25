
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

    tools {
        jdk 'JDK'
        maven 'MAVEN'
    }

    environment {
        TOMCAT_HOME = "C:\\appache\\apache-tomcat-9.0.115-windows-x64\\apache-tomcat-9.0.115"
        WAR_NAME = "java.war"
        CONTEXT_PATH = "java"
        TOMCAT_PORT = "8081"
    }

    stages {
        stage('Build WAR') {
            steps {
                echo "Building WAR..."
                bat 'mvn clean package'
            }
        }

        stage('Stop Tomcat') {
            steps {
                echo "Stopping Tomcat..."
                bat """
                set CATALINA_HOME=${env.TOMCAT_HOME}
                "${env.TOMCAT_HOME}\\bin\\shutdown.bat"
                ping 127.0.0.1 -n 6 > nul
                """
            }
        }

        stage('Deploy WAR') {
            steps {
                echo "Deploying WAR..."
                bat """
                copy /Y target\\${WAR_NAME} ${env.TOMCAT_HOME}\\webapps\\
                """
            }
        }

        stage('Start Tomcat') {
            steps {
                echo "Starting Tomcat..."
                bat """
                set CATALINA_HOME=${env.TOMCAT_HOME}
                "${env.TOMCAT_HOME}\\bin\\startup.bat"
                ping 127.0.0.1 -n 6 > nul
                """
            }
        }
    }

    post {
        success {
            echo "Deployment complete! Access your app at http://localhost:${TOMCAT_PORT}/${CONTEXT_PATH}/index.jsp"
        }
        failure {
            echo "Deployment failed! Check WAR name, paths, or Tomcat logs."
        }
    }
}
