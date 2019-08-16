ARG VERSION=3.8
FROM alpine:${VERSION}

LABEL Maintainer "Balluff SHW"
LABEL Version "3.9"
LABEL Vendor "Balluff"
LABEL Name "SSH server in a container"
LABEL Architecture "arm32v7"

# Upgrade the base system and install openssh
# Also edit the SSH config to permit root access
RUN apk update && apk upgrade
RUN apk add openssh \
        && rm -rf /var/cache/apk/* /tmp/*

# Add SSHD config
ADD etc/ssh/sshd_config /etc/ssh/sshd_config

# Add the entrypoint script
ADD entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 22

ENTRYPOINT [ "entrypoint.sh" ]