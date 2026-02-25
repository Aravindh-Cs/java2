// pipeline {
//     agent any

//     tools {
//         jdk 'JDK'
//         maven 'MAVEN'
//     }

//     stages {
//         stage('Build WAR') {
//             steps {
//                 bat 'mvn clean package'
//             }
//         }

//         stage('Deploy to Tomcat') {
//             steps {
//                 bat '''
//                 echo Deploying WAR to Tomcat...
//                copy /Y target\\java.war C:\\appache\\apache-tomcat-9.0.115-windows-x64\\apache-tomcat-9.0.115\\webapps\\
//                 '''
//             }
//         }
//     }
// }



pipeline {
    agent any

    tools {
        jdk 'JDK'          // Name of JDK configured in Jenkins
        maven 'MAVEN'      // Name of Maven configured in Jenkins
    }

    environment {
        // Set TOMCAT_HOME to your actual Tomcat folder
        TOMCAT_HOME = "C:\\appache\\apache-tomcat-9.0.115-windows-x64\\apache-tomcat-9.0.115"
        WAR_NAME = "java.war" // Change if Maven produces a different WAR
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code..."
                git 'https://github.com/Aravindh-Cs/java2.git'
            }
        }

        stage('Build WAR') {
            steps {
                echo "Building WAR..."
                bat 'mvn clean package'
            }
        }

        stage('Stop Tomcat') {
            steps {
                echo "Stopping Tomcat..."
                bat '"%TOMCAT_HOME%\\bin\\shutdown.bat"'
                bat 'timeout /t 5'  // Wait 5 seconds for Tomcat to stop
            }
        }

        stage('Deploy WAR') {
            steps {
                echo "Deploying WAR to Tomcat..."
                bat 'copy /Y target\\%WAR_NAME% "%TOMCAT_HOME%\\webapps\\"'
            }
        }

        stage('Start Tomcat') {
            steps {
                echo "Starting Tomcat..."
                bat '"%TOMCAT_HOME%\\bin\\startup.bat"'
            }
        }
    }

    post {
        success {
            echo "Deployment complete! Access your app at http://localhost:8080/java/index.jsp"
        }
        failure {
            echo "Deployment failed! Check WAR name, paths, or Tomcat logs."
        }
    }
}
