# OpenStack and AWS Docker Demo

This quick Terraform configuration will create a virtual machine in OpenStack and AWS and then provision Docker on both.

## Instructions

1. Create an SSH key pair:

```bash
$ ssh-keygen -N '' -t rsa -f files/docker
```

2. Edit `files/aws` and `files/openrc`. Replace `CHANGEME` with the appropriate cloud credentials.

3. Source both credential files:

```bash
$ source files/aws
$ source files/openrc
```

4. Deploy:

```bash
$ terraform apply
```


When finished, Docker will be installed on both virtual machines. Docker must be manually controlled, but an extension of this demo would be to use the information dynamically obtained (such as the virtual machines' IP addresses) to further orchestrate the Docker installations.
