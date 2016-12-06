resource "aws_key_pair" "docker" {
  key_name = "docker"
  public_key = "${file("files/docker.pub")}"
}

resource "aws_security_group" "docker" {
  name = "docker"
  description = "Rules for Docker demo"

  ingress {
    from_port = 1
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "docker" {
  ami = "ami-1dbdea7d"
  instance_type = "m1.small"
  key_name = "${aws_key_pair.docker.key_name}"
  security_groups = ["${aws_security_group.docker.name}"]

  connection {
    user = "ubuntu"
    private_key = "${file("files/docker")}"
    host = "${aws_instance.docker.public_ip}"
  }

  provisioner "remote-exec" {
    scripts = [
      "files/install_docker.sh"
    ]
  }
}
