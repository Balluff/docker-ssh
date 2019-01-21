# About

This project provides an Alpine Linux based Docker container with SSH support.

## References

- Official [Alpine Docker Hub image](https://hub.docker.com/_/alpine/) as base
- Password generation from [How-To Geek](https://www.howtogeek.com/howto/30184/10-ways-to-generate-a-random-password-from-the-command-line/)
- [Redirect user and password information from file to chpasswd](https://www.howtoforge.com/linux-chpasswd-command/)

## Container usage

Pull and run this container via:

```sh
$ docker run --name test_ssh -d -p 2222:22 balluff/ssh
```

If you the follow the example the container is executed in the background `-d` and the generated password is not displayed. So you need to have a view in the logs for the automatic generated root password:

```sh
$ docker logs test_ssh
ssh-keygen: generating new host keys: RSA DSA ECDSA ED25519
Generate a new root password for...
root:{PASSWORD}
chpasswd: password for 'root' changed
Server listening on 0.0.0.0 port 22.
Server listening on :: port 22.
```

## Connect via SSH

Now you can connect over SSH to the container. Because we used an customed SSH port don't forget `-p`:

```sh
$ ssh root@{IP | HOSTNAME} -p 2222
```