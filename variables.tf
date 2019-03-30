variable "name" {
  type        = "string"
  description = "The human-readable name for the server. Used when naming the Linode (with a suffix of '-wg')"
}

variable "ssh_keys" {
  type        = "list"
  description = "SSH public keys used to log in as root to the server"
}

variable "region" {
  type        = "string"
  default     = "us-central"
  description = "Region to place the Linode in"
}

variable "type" {
  type        = "string"
  default     = "g6-standard-2"
  description = "Plan type for the Linode"
}

variable "deploy_repo" {
  type        = "string"
  default     = "https://github.com/akerl/deploy-wireguard-server"
  description = "Repo to use for Ansible playbook"
}

variable "source_image_id" {
  type        = "string"
  default     = "linode/ubuntu18.04"
  description = "Source image to build on"
}
