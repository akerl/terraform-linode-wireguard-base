data "template_file" "setup" {
  template = "${file("${path.module}/assets/setup.sh")}"

  vars {
    deploy_repo = "${var.deploy_repo}"
  }
}

resource "linode_instance" "vpn" {
  label = "${var.name}-wg"

  region = "${var.region}"
  type   = "${var.type}"

  disk {
    label            = "root"
    size             = 10240
    authorized_keys  = ["${var.ssh_keys}"]
    authorized_users = ["${var.ssh_users}"]
    image            = "${var.source_image_id}"
  }

  config {
    label  = "default"
    kernel = "linode/grub2"

    devices {
      sda = {
        disk_label = "root"
      }
    }
  }

  provisioner "file" {
    source      = "${path.module}/assets/sshd_config"
    destination = "/etc/ssh/sshd_config"
  }

  provisioner "file" {
    content     = "${data.template_file.setup.rendered}"
    destination = "/root/setup.sh"
  }

  provisioner "remote-exec" {
    inline = ["bash /root/setup.sh"]
  }
}
