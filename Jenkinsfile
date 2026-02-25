
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
        jdk 'JDK'       // Name of your Jenkins JDK tool
        maven 'MAVEN'   // Name of your Jenkins Maven tool
    }

    environment {
        TOMCAT_HOME = "C:\\appache\\apache-tomcat-9.0.115-windows-x64\\apache-tomcat-9.0.115"
        TOMCAT_PORT = "8081"
        WAR_NAME = "java.war"
        CONTEXT_PATH = "java"
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
                "${TOMCAT_HOME}\\bin\\shutdown.bat"
                """
                echo "Waiting 5 seconds..."
                bat 'timeout /t 5 /nobreak'
            }
        }

        stage('Deploy WAR') {
            steps {
                echo "Deploying WAR to Tomcat..."
                bat """
                copy /Y target\\${WAR_NAME} ${TOMCAT_HOME}\\webapps\\
                """
            }
        }

        stage('Start Tomcat') {
            steps {
                echo "Starting Tomcat..."
                bat """
                "${TOMCAT_HOME}\\bin\\startup.bat"
                """
            }
        }

        stage('Wait for Deployment') {
            steps {
                echo "Waiting for app to be available at http://localhost:${TOMCAT_PORT}/${CONTEXT_PATH}/index.jsp ..."
                script {
                    timeout(time: 60, unit: 'SECONDS') {
                        waitUntil {
                            try {
                                def resp = httpRequest url: "http://localhost:${TOMCAT_PORT}/${CONTEXT_PATH}/index.jsp", validResponseCodes: '200'
                                return resp.status == 200
                            } catch (Exception e) {
                                sleep 2
                                return false
                            }
                        }
                    }
                }
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
