FROM jenkins/jenkins:lts

# Install plugins (temp)
RUN jenkins-plugin-cli --plugins workflow-aggregator docker-workflow git

# TODO: make jobs and copy them
# COPY jobs/ /var/jenkins_home/jobs/