# terraform_aws_modules_repo

# Terraform AWS Modules Repository

This repository contains **reusable Terraform modules** for provisioning AWS infrastructure. Each module is designed to be modular, configurable, and versioned independently to support scalable deployments across environments.

---

## Table of Contents

- [Modules](#modules)  
- [Getting Started](#getting-started)  
- [Usage](#usage)  
- [Versioning](#versioning)  
- [Contributing](#contributing)  
- [License](#license)  

---

## Modules

This repository currently includes the following modules:

### 1. VPC Module
- Creates a VPC with public and private subnets.
- Creates NAT gateways, route tables, and internet gateways.
- Example variables: `vpc_cidr`, `public_subnet_cidrs`, `private_subnet_cidrs`, `azs`.

### 2. Security Groups Module
- Creates security groups for Application Load Balancer (ALB), application servers, and databases.
- Configurable ingress and egress rules.
- Example variables: `name`, `vpc_id`, `http_port`, `ssh_port`, `db_port`, `Admin_CIDR`.

### 3. EC2 Module
- Launches EC2 instances with user-defined instance types.
- Supports multiple instances using `for_each`.
- Configurable with `subnet_id`, `security_group_ids`, `key_name`, `user_data`.
- Includes output for instance IDs and public IPs.

---

## Getting Started

1. **Clone the repository**

```bash
git clone https://github.com/nanafilbert/terraform_aws_modules_repo.git
cd terraform_aws_modules_repo
Configure GitHub Actions (if using CI/CD)

Add a GitHub Token in your repository secrets if you plan to use version bumping workflows.

Usage
Example usage in a Terraform deployment repository:

hcl
Copy
Edit
module "vpc" {
  source          = "git::https://github.com/nanafilbert/terraform_aws_modules_repo.git//modules/vpc"
  name            = "my-vpc"
  vpc_cidr        = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs             = ["us-east-2a", "us-east-2b"]
}

module "security_grps" {
  source = "git::https://github.com/nanafilbert/terraform_aws_modules_repo.git//modules/security_grps"
  name   = "my-app"
  vpc_id = module.vpc.vpc_id
  http_port = 80
  ssh_port  = 22
  db_port   = 3306
  Admin_CIDR = "0.0.0.0/0"
}
Versioning
This repository uses Git tags for versioning.
Each module can be referenced by tag in deployment repositories:

hcl
Copy
Edit
module "vpc" {
  source  = "git::https://github.com/nanafilbert/terraform_aws_modules_repo.git//modules/vpc?ref=v1.0.0"
}
v1.0.0 - Initial release with VPC, Security Groups, and EC2 modules.

Contributing
Fork the repository

Create a feature branch

Make changes and test your module

Push the branch and create a Pull Request

Ensure your module follows semantic versioning and proper outputs

License
This project is licensed under the MIT License.

Author: Filbert Nana Blessing
Contact: GitHub


