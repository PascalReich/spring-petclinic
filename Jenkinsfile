pipeline {
    agent any

    stages {
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
