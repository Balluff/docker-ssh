FROM alpine:3.8

LABEL Maintainer "Andreas Elser"
LABEL Version "1.0"
LABEL Vendor "Balluff"
LABEL Name "SSH container"

# Upgrade the base system and install openssh
# Also edit the SSH config to permit root access
RUN apk update && apk upgrade
RUN apk add openssh \
        && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
        && rm -rf /var/cache/apk/* /tmp/*

# Add the entrypoint script
ADD ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 22

ENTRYPOINT [ "entrypoint.sh" ]