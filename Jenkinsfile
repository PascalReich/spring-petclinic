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
                sh '''
                    chmod +x mvnw
                    ./mvnw clean verify sonar:sonar \
                      -Dsonar.projectKey=spring-petclinic \
                      -Dsonar.projectName=spring-petclinic \
                      -Dsonar.host.url=http://sonarqube:9000 \
                      -Dsonar.sourceEncoding=UTF-8 \
                      -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml \
                      -Dsonar.token="$(cat /run/secrets/sonar-token)"
                '''
            }
        }
        stage('OWASP ZAP Scan') {
            steps {
                script {
                    // Jenkins calls the ZAP container internally at http://owasp-zap:8080
                    sh '''
                        echo "Starting OWASP ZAP..."
                        for i in {1..30}; do
                            if curl -s http://owasp-zap:8080/ > /dev/null; then
                                echo "OWASP ZAP is up!"
                                break
                            else
                                sleep 5
                            fi
                        done
                    '''
                    
                    // Trigger the spider scan. ZAP scans the petclinic container over the shared network
                    sh '''
                        echo "Performing spider scan..."
                        curl -s 'http://owasp-zap:8080/JSON/spider/action/scan/?url=http://petclinic:8080'
                    '''
                    
                    // Wait for the scan to complete to ensure the pipeline doesn't exit prematurely
                    sh '''
                        echo "Waiting for scan to complete..."
                        while true; do
                            status=$(curl -s 'http://owasp-zap:8080/JSON/spider/view/status/')
                            if echo "$status" | grep -q '"status":"100"'; then
                                echo "Scan completed!"
                                break
                            fi
                            echo "Scan in progress: $status"
                            sleep 5
                        done
                    '''
                    
                    // NEW: Generate and save the HTML report
                    sh '''
                        echo "Generating ZAP Security Report..."
                        curl -s http://owasp-zap:8080/OTHER/core/other/htmlreport/ > zap-security-report.html
                    '''
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'zap-security-report.html', allowEmptyArchive: true
                }
            }
        }
    }
}
