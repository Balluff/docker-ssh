#!/bin/sh

# Generate host keys if not present
ssh-keygen -A

# Check if the password file was created
if [ -f /tmp/pwd.txt ]
then
    echo "Password file >pwd.txt< found!"
else
    echo "Password file >pwd.txt< not found!"
    exit 1
fi

pwd=$(cat /tmp/pwd.txt)
# Check if a string is stored inside the password file
if [ "$pwd" ]
then
    echo "Password file >pwd.txt< is not empty! Password is: $pwd"
else
    echo "Password file >pwd.txt< is empty!"
    exit 1
fi

# Establish a new SSH connection to the server

# Use "sshpass" and create a new file on the server
sshpass -p $pwd ssh -p 22 -o=StrictHostKeyChecking=no root@171.6.0.10 "cd /home/; touch testfile; echo "SSH connection established" >> testfile"

# Use "sshpass" and transfer the file via "scp"
sshpass -p $pwd scp -P 22 -o=StrictHostKeyChecking=no root@171.6.0.10:/home/testfile /tmp/testfile

if [ -f /tmp/testfile ]
then
    echo "Testfile was sucessfully created on the server! "
    cat /tmp/testfile
else
    echo "Testfile not found on the client!"
    exit 1
fi

exit 0