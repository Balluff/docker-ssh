# Use the Alpine base image
FROM alpine:3.8

# Some information
LABEL Maintainer "Andreas Elser"
LABEL Version "1.0"
LABEL Vendor "Balluff"
LABEL Name "SSH container tests"

# Install openssh
RUN apk update && apk upgrade
RUN apk add openssh sshpass \
    && rm -rf /var/cache/apk/* /tmp/*

# Copy the testing script and make it executable
ADD entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Run the test script
ENTRYPOINT [ "entrypoint.sh" ]