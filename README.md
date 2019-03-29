terraform-linode-wireguard-base
=========

[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Terraform module that creates a [Linode](https://linode.com) with package updates and [wireguard](https://www.wireguard.com) deployed but not configured. This uses [an Ansible playbook](https://github.com/akerl/deploy-wireguard-server) to set up Wireguard.

## Usage

```
module "vpn" {
  source  = "github.com/akerl/terraform-linode-wireguard-base"
  name = "vpn"
  ssh_keys = ["PUT_YOUR_PUBKEY_HERE"]

  users = [
    "alfa",
    "beta",
  ]
}
```

## License

terraform-linode-wireguard-base is released under the MIT License. See the bundled LICENSE file for details.
