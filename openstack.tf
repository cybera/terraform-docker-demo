resource "openstack_compute_keypair_v2" "docker" {
  name = "docker"
  public_key = "${file("files/docker.pub")}"
}

resource "openstack_compute_secgroup_v2" "docker" {
  name = "docker"
  description = "Rules for Docker demo"

  rule {
    ip_protocol = "tcp"
    from_port = 1
    to_port = 65535
    cidr = "0.0.0.0/0"
  }

  rule {
    ip_protocol = "udp"
    from_port = 1
    to_port = 65535
    cidr = "0.0.0.0/0"
  }

  rule {
    ip_protocol = "icmp"
    from_port = -1
    to_port = -1
    cidr = "0.0.0.0/0"
  }
}

resource "openstack_compute_floatingip_v2" "docker" {
  pool = "nova"
}

resource "openstack_compute_instance_v2" "docker" {
  name = "docker"
  image_name = "Ubuntu 14.04"
  flavor_name = "m1.medium"
  key_pair = "${openstack_compute_keypair_v2.docker.name}"
  security_groups = ["${openstack_compute_secgroup_v2.docker.name}"]
  floating_ip = "${openstack_compute_floatingip_v2.docker.address}"

  connection {
    user = "ubuntu"
    private_key = "${file("files/docker")}"
    host = "${openstack_compute_instance_v2.docker.access_ip_v4}"
  }

  provisioner "remote-exec" {
    scripts = [
      "files/install_docker.sh"
    ]
  }
}
