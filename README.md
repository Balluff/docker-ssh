# About

This project provides an Alpine Linux based Docker container with SSH support.
On the first start it creates a new random password for the root user so please follow the steps below to determine the password and work with the container.

## References

- Official [Alpine Docker Hub image](https://hub.docker.com/_/alpine/) as base
- Password generation from [How-To Geek](https://www.howtogeek.com/howto/30184/10-ways-to-generate-a-random-password-from-the-command-line/)
- [Redirect user and password information from file to chpasswd](https://www.howtoforge.com/linux-chpasswd-command/)
- [SSHPASS](https://www.cyberciti.biz/faq/noninteractive-shell-script-ssh-password-provider/) application for script based SSH access

## Container usage

Pull and run this container with the following example:

```sh
docker run --name test_ssh -d -p 2222:22 balluff/ssh
```

If you follow the example the container is executed in the background `-d` and the auto-generated password is not displayed. So you need to have a view in the logs for the automatic generated root password:

```sh
docker logs test_ssh
ssh-keygen: generating new host keys: RSA DSA ECDSA ED25519
Generate a new root password for...
{PASSWORD}
chpasswd: password for 'root' changed
Server listening on 0.0.0.0 port 22.
Server listening on :: port 22.
```

## Connect via SSH

Now you can connect over SSH to the container. Because we used an customed SSH port don't forget to set the port parameter `-p`:

```sh
ssh root@{IP | HOSTNAME} -p 2222
```

## Tests

Inside the `test` directory a `Dockerfile` and a script called `entrypoint.sh` can be used for manual or automated system tests.

### Automated Tests

Automated tests will be triggered after every git push because the repository is linked to the Docker Cloud.
The setting on the Docker Cloud allows to build and run the container image defined inside the `test` directory and the top level `docker-compose.test.yml` file.
With the `sut` compose property the build process knows that to do.

### Manual Tests

Running the tests manually on the local machine needs Docker Compose installed.
Run the tests with `docker-compose -f docker-compose.test.yml up` on the same level there the test file is and wait, till the Alpine Linux base image was downloaded and the build process has finished.
After that you will see the test result in your terminal.

```sh
docker-compose -f docker-compose.test.yml up
Creating network "docker-ssh_ssh_net" with driver "bridge"
Creating blf_ssh ... done
Creating sut_ssh ... done
Attaching to blf_ssh, sut_ssh
blf_ssh    | ssh-keygen: generating new host keys: RSA DSA ECDSA ED25519 
blf_ssh    | Server listening on 0.0.0.0 port 22.
blf_ssh    | Server listening on :: port 22.
sut_ssh    | ssh-keygen: generating new host keys: RSA DSA ECDSA ED25519 
sut_ssh    | Password file >pwd.txt< found!
sut_ssh    | Password file >pwd.txt< is not empty! Password is: {PASSWORD}
sut_ssh    | Warning: Permanently added '171.6.0.10' (ECDSA) to the list of known hosts.
blf_ssh    | Failed password for root from 171.6.0.20 port 55648 ssh2
sut_ssh    | Permission denied, please try again.
blf_ssh    | Connection closed by authenticating user root 171.6.0.20 port 55648 [preauth]
blf_ssh    | Failed password for root from 171.6.0.20 port 55650 ssh2
sut_ssh    | Permission denied, please try again.
blf_ssh    | Connection closed by authenticating user root 171.6.0.20 port 55650 [preauth]
sut_ssh    | Testfile was sucessfully created on the server! 
sut_ssh    | SSH connection established
sut_ssh exited with code 0
```

Finish and stop the current compose service with `CTRL` + `C` and enter `docker-compose -f docker-compose.test.yml down` to cleanup your system.

**Note:** Just the container and networks will be removed. If you want to delete the volume with the stored data inside you need to run `docker volume rm {VOLUME NAME}`.

## Architecture

The following picture shows the test scenario based on the scripts between the server and client.

![ssh_container_server_client_tests](https://raw.githubusercontent.com/Balluff/docker-ssh/master/architecture/ssh_container_server_client_tests.png)