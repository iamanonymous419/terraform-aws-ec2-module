# Terraform EC2 Spot Instance Module

> **Note:**  
> This module is designed to **provision EC2 Spot Instances** in AWS. Spot Instances allow you to take advantage of unused EC2 capacity at a discounted cost compared to On-Demand pricing.  

This Terraform module provisions an EC2 **Spot Instance** in AWS, along with the required resources such as security groups, SSH key pairs, and root block storage. It is highly customizable and supports a variety of configurations for deployment environments.

## Requirements

- Terraform version `>= 1.0.0`
- AWS provider version `>= 5.30`
- AWS account with necessary permissions to create EC2 instances, security groups, key pairs, etc.

## Usage

### Basic Example

```hcl
module "master" {
  source  = "iamanonymous419/custom-module/aws//modules/spot"
  version = "3.0.0"
  instance_name                = "master"
  env                          = "your_env"
  instance_key_pair_location   = "your_key_pair_location"
  instance_key_pair            = "your_key_pair"
  associate_public_ip_address  = true
  instance_volume_type         = "gp2"
  instance_type                = "t2.micro"
  instance_ami                 = "ami-12345678" # Replace with your AMI ID
  instance_storage             = 20
  instance_security_group_name = "master"
  ingress_rules                = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP"
    }
  ]
  subnet_id                    = "your_subnet_id"
  vpc_id                       = "your_vpc_id"
}
```

> **Reminder:**  
> The instance provisioned through this module will request a **Spot Instance**.

---

## Inputs

| Variable                      | Description                                                                 | Type     | Default | Required |
| ----------------------------- | --------------------------------------------------------------------------- | -------- | ------- | -------- |
| `instance_name`               | The name of the EC2 Spot instance.                                           | `string` | `N/A`   | Yes      |
| `instance_type`               | The EC2 instance type (e.g., `t2.micro`, `t2.medium`, `t3.large`).           | `string` | `N/A`   | Yes      |
| `instance_ami`                | The AMI ID for the EC2 Spot instance.                                        | `string` | `N/A`   | Yes      |
| `instance_storage`            | The storage size in GB for the EC2 instance.                                | `number` | `N/A`   | Yes      |
| `instance_key_pair`           | The name of the SSH key pair for EC2 access.                                | `string` | `N/A`   | Yes      |
| `instance_key_pair_location`  | The local path to the SSH key pair file for EC2 access.                     | `string` | `N/A`   | Yes      |
| `instance_security_group_name`| The name of the security group for the EC2 instance.                        | `string` | `N/A`   | Yes      |
| `ingress_rules`               | List of ingress rules for the security group.                               | `list`   | `N/A`   | Yes      |
| `associate_public_ip_address` | Whether to associate a public IP address with the EC2 instance.             | `bool`   | `false` | No       |
| `instance_volume_type`        | The volume type for the EC2 root block device (e.g., `gp2`, `gp3`, `io1`).  | `string` | `gp3`   | No       |
| `env`                         | The deployment environment (e.g., `dev`, `staging`, `production`).           | `string` | `N/A`   | Yes      |
| `subnet_id`                   | The ID of the subnet to launch the EC2 instance in.                         | `string` | `N/A`   | Yes      |
| `vpc_id`                      | The ID of the VPC where the EC2 instance will be launched.                  | `string` | `N/A`   | Yes      |

---

## Outputs

| Output Name                  | Description                                                                |
| ---------------------------- | -------------------------------------------------------------------------- |
| `instance_id`                | The ID of the created EC2 instance.                                        |
| `instance_dns`               | The public DNS of the created EC2 instance.                                |
| `instance_public_ip`         | The public IP address of the EC2 instance (if assigned).                   |
| `instance_private_ip`        | The private IP assigned to the EC2 instance within the VPC.                |
| `instance_availability_zone` | The Availability Zone where the EC2 instance is deployed.                  |
| `instance_tags`              | Tags associated with the EC2 instance. Useful for identification.          |
| `instance_security_groups`   | The security groups associated with the EC2 instance.                      |

```hcl
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
```

#### Explanation of Each Output:

- instance_dns:
  - **Description**: The public DNS address of the EC2 instance.
  - **Explanation**: This output provides the public DNS name of the EC2 instance, useful for accessing the instance over the internet.

- instance_id:
  - **Description**: The ID of the EC2 instance.
  - **Explanation**: The unique identifier assigned to the EC2 instance, useful for management and automation.

- instance_public_ip:
  - **Description**: The public IP address of the EC2 instance.
  - **Explanation**: The public IP address assigned to the EC2 instance, used to access it from outside the VPC.

- instance_private_ip:
  - **Description**: The private IP address of the EC2 instance.
  - **Explanation**: The internal IP address used for communication within the VPC.

- instance_availability_zone:
  - **Description**: The Availability Zone of the EC2 instance.
  - **Explanation**: Indicates the AZ within the AWS Region where the instance is launched, helpful for high availability and redundancy.

- instance_tags:
  - **Description**: Tags associated with the EC2 instance.
  - **Explanation**: Key-value pairs used for organizing, billing, and managing AWS resources.

- instance_security_groups:
  - **Description**: The security groups associated with the EC2 instance.
  - **Explanation**: Lists the security groups linked to the EC2 instance, which control its network traffic.

---

## Module Structure

This module consists of the following resources:

1. **EC2 Spot Instance**: The main resource for creating a Spot Instance, including root block storage and key pair.
2. **Security Group**: Dynamically creates security group rules based on the ingress rules provided.
3. **Key Pair**: Provisions an SSH key pair for EC2 instance access.
4. **Outputs**: Outputs the instance ID, DNS, public IP, and other relevant information for the created EC2 instance.

---

## Example Configuration

### Example 1: Basic EC2 Spot Instance Setup

```hcl
module "basic" {
  source  = "iamanonymous419/custom-module/aws//modules/spot"
  version = "3.0.0"
  instance_name                = "basic-instance"
  instance_key_pair_location   = "path/to/key_pair.pub"
  instance_key_pair            = "my-key-pair"
  associate_public_ip_address  = true
  instance_type                = "t2.micro"
  instance_ami                 = "ami-0c55b159cbfafe1f0" # Replace with your AMI ID
  instance_storage             = 20
  instance_security_group_name = "basic-sg"
  ingress_rules                = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH"
    }
  ]
  subnet_id                    = "subnet-xxxxxxxx"
  vpc_id                       = "vpc-xxxxxxxx"
}
```

> **Again:**  
> The instance launched here will be a **Spot Instance**, not an On-Demand one.

