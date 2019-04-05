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
        file_path = "${var.ansible_repo_path}/linode/bootstrap.yml"
      }
    }

    plays {
      playbook = {
        file_path = "${var.ansible_repo_path}/linode/setup.yml"
      }
    }

    plays {
      playbook = {
        file_path = "${var.ansible_repo_path}/main.yml"
        skip_tags = ["users"]
      }
    }

    defaults {
      extra_vars = {
        ansible_python_interpreter = "/usr/bin/python3"
      }
    }

    ansible_ssh_settings {
      ssh_keyscan_timeout = 360
    }
  }
}
