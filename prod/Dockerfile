FROM openjdk:27-ea-slim-bookworm

RUN apt-get update && apt-get install -y openssh-server python3
RUN echo "PubkeyAuthentication yes\nAllowUsers server\nClientAliveInterval 600\nClientAliveCountMax 0" >> /etc/ssh/sshd_config

RUN useradd -m -s /bin/bash server

WORKDIR /home/server

RUN mkdir -p .ssh && chown server:server .ssh && chmod 700 .ssh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p /run/sshd

USER root

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
