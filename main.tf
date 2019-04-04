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

  provisioner "ansible" {
    plays {
      playbook = {
        file_path = "ansible/linode/bootstrap.yml"
      }

      extra_vars = {
        ansible_python_interpreter = "/usr/bin/python3"
      }
    }

    plays {
      playbook = {
        file_path = "ansible/linode/setup.yml"
      }

      extra_vars = {
        ansible_python_interpreter = "/usr/bin/python3"
      }
    }

    plays {
      playbook = {
        file_path = "ansible/main.yml"
        skip_tags = ["users"]
      }

      extra_vars = {
        ansible_python_interpreter = "/usr/bin/python3"
      }
    }
  }
}
