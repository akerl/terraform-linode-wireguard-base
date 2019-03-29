output "ip_address" {
  value       = "${linode_instance.vpn.ip_address}"
  description = "Public IP of the Linode"
}

output "linode_id" {
  value       = "${linode_instance.vpn.id}"
  description = "The ID of the Linode"
}

output "disk_id" {
  value       = "${linode_instance.vpn.disk.0.id}"
  description = "The disk ID for the root filesystem"
}
