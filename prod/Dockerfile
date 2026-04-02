

FROM openjdk:27-ea-slim-bookworm

RUN apt-get update && apt-get install -y openssh-server python3
RUN echo "PubkeyAuthentication yes\nAllowUsers server\nClientAliveInterval 600\nClientAliveCountMax 0" >> /etc/ssh/sshd_config

RUN useradd -m -s /bin/bash server

WORKDIR /home/server

RUN mkdir -p .ssh

COPY access.pub ssh_key.pub

RUN cat /home/server/ssh_key.pub >> /home/server/.ssh/authorized_keys

RUN chown -R server:server /home/server/.ssh

RUN chmod 600 /home/server/.ssh/authorized_keys
    
USER root

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]