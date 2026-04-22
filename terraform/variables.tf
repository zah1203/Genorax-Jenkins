variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "genorax"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.50.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.50.1.0/24"
}

variable "allowed_ssh_cidrs" {
  description = "CIDRs allowed to SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_jenkins_cidrs" {
  description = "CIDRs allowed to access Jenkins UI"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "instance_type" {
  description = "EC2 instance type for Jenkins"
  type        = string
  default     = "t3.large"
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 40
}

variable "terraform_version" {
  description = "Terraform version to install on the instance"
  type        = string
  default     = "1.8.5"
}

variable "public_key_path" {
  description = "Local path to public SSH key. Leave empty to skip key pair creation"
  type        = string
  default     = ""
}

variable "jenkins_admin_user" {
  description = "Initial admin username note for setup"
  type        = string
  default     = "admin"
}

variable "extra_tags" {
  description = "Extra tags"
  type        = map(string)
  default     = {}
}
