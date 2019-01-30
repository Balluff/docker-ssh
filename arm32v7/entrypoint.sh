#!/bin/sh

# generate host keys if not present
ssh-keygen -A

# check wether a random root-password is provided
if [ ! -f /home/pwd.txt ]; then
    echo "Generate a new root password for... "; \
    echo "root:"`(< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c${1:-12};echo)` >> /home/pwd.txt; \
    cat /home/pwd.txt; \
    cat /home/pwd.txt | chpasswd;
fi

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"