variable "instances" {
  description = "Map of instances to launch (key = instance name, value = instance type)"
  type        = map(string)
}

variable "key_name" {
  description = "Key pair name for EC2"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach"
  type        = list(string)
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "User data script for EC2 initialization"
  type        = string
}

variable "name" {
  description = "Base name for EC2 instances"
  type        = string
}

variable "tags" {
  description = "Tags to apply to EC2"
  type        = map(string)
  default     = {}
}
