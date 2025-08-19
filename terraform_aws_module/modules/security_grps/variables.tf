variable "name" {
  description = "Name of the Security Group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the Security Group will be created"
  type        = string
}

variable "http_port" {
  description = "Port for the Application Load Balancer"
  type        = number
 
  
}

variable "ssh_port" {
  description = "Port for SSH access"
  type        = string
  
}

variable "protocol" {
  description = "Protocol for TCP-based services"
  type        = string
  default     = "tcp"
}

variable "protocol_2" {
  description = "Protocol for all traffic"
  type        = string
  default     = "-1"
}

variable "outbound_cidr_blocks" {
  description = "CIDR blocks for the Security Group"
  type        = list(string)
  default     = []
}
variable "outbound_port" {
  description = "Egress port for the Security Group"
  type        = number
  
}

variable "https_port" {
  description = "Second port for the Application Load Balancer"
  type        = number
}


variable "db_port" {
  description = "Port for the Database"
  type        = number
}

variable "tags" {
  description = "Tags to apply to the Security Group"
  type        = map(string)
  default     = {}
}

variable "Admin_CIDR" {
  description = "Public Ip of Admin CIDR"
  type        = string
  
}