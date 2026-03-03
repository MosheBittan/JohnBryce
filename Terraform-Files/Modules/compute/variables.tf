# Inside modules/compute/variables.tf
variable "ami_id" {
  type        = string
  description = "The ID of the AMI to use for the EC2 instance"
}

variable "instance_type" {
  type    = string
  default = "t3.micro" # You can set a default!
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string) # Because an instance can have multiple SGs
}

variable "is_public" {
  type    = bool
  default = false
}

variable "server_name" {
  type = string
}
