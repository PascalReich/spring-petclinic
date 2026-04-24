#!/bin/bash
cat /run/secrets/prod_ssh/id_ed25519.pub >> /home/server/.ssh/authorized_keys
chown server:server /home/server/.ssh/authorized_keys
chmod 600 /home/server/.ssh/authorized_keys
exec /usr/sbin/sshd -D
