pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "M3"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', url: 'https://github.com/PascalReich/spring-petclinic.git'

                // Run Maven on a Unix agent.
                sh "mvn dependency:go-offline"
                
                sh "mvn package -DskipTests"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }


        stage('Sonar') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh '''
                        chmod +x mvnw
                        ./mvnw clean verify sonar:sonar \
                          -Dsonar.projectKey=spring-petclinic \
                          -Dsonar.projectName=spring-petclinic \
                          -Dsonar.sourceEncoding=UTF-8 \
                          -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
                    '''
                }
            }
        }
    }
}
