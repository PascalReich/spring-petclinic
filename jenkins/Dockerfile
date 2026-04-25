# initial content from https://www.jenkins.io/doc/book/installing/docker/

FROM jenkins/jenkins:2.492.3-jdk21
USER root
RUN apt-get update && apt-get install -y lsb-release ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
    https://download.docker.com/linux/debian $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && apt-get install -y docker-ce-cli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# install java, maven, and ansible
RUN apt-get update && apt-get install -y maven default-jdk git python3 python3-pip && \
    pip3 install --break-system-packages ansible
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow json-path-api configuration-as-code sonar git prometheus job-dsl"
