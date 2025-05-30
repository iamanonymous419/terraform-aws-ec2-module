output "master_instance_dns" {
  description = "The public DNS of the master EC2 instance"
  value       = module.master.instance_dns
}

output "master_instance_id" {
  description = "The ID of the master EC2 instance"
  value       = module.master.instance_id
}

output "master_instance_public_ip" {
  description = "The public IP address of the master EC2 instance"
  value       = module.master.instance_public_ip
}

output "master_instance_private_ip" {
  description = "The private IP address of the master EC2 instance"
  value       = module.master.instance_private_ip
}

output "master_instance_availability_zone" {
  description = "The Availability Zone of the master EC2 instance"
  value       = module.master.instance_availability_zone
}

output "master_instance_tags" {
  description = "Tags associated with the master EC2 instance"
  value       = module.master.instance_tags
}

output "master_instance_security_groups" {
  description = "The security groups associated with the master EC2 instance"
  value       = module.master.instance_security_groups
}

# output for master_2 instance

output "master_2_instance_dns" {
  description = "The public DNS of the master_2 EC2 instance"
  value       = module.master_2.instance_dns
}

output "master_2_instance_id" {
  description = "The ID of the master_2 EC2 instance"
  value       = module.master_2.instance_id
}

output "master_2_instance_public_ip" {
  description = "The public IP address of the master_2 EC2 instance"
  value       = module.master_2.instance_public_ip
}

output "master_2_instance_private_ip" {
  description = "The private IP address of the master_2 EC2 instance"
  value       = module.master_2.instance_private_ip
}

output "master_2_instance_availability_zone" {
  description = "The Availability Zone of the master_2 EC2 instance"
  value       = module.master_2.instance_availability_zone
}

output "master_2_instance_tags" {
  description = "Tags associated with the master_2 EC2 instance"
  value       = module.master_2.instance_tags
}

output "master_2_instance_security_groups" {
  description = "The security groups associated with the master_2 EC2 instance"
  value       = module.master_2.instance_security_groups
}
