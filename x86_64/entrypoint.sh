#!/bin/sh

# Generate host keys if not present
ssh-keygen -A

# Check wether a random root-password is provided
# https://www.howtogeek.com/howto/30184/10-ways-to-generate-a-random-password-from-the-command-line/
if [ ! -f /home/pwd.txt ]
then
    echo "Generate a new root password... "
    echo "root:"`(< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c${1:-12};echo)` >> /home/pwd.txt
    cat /home/pwd.txt
    cat /home/pwd.txt | chpasswd
fi

# Do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"