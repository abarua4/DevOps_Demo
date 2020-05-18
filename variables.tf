variable "cloud_provider" {
    default = "aws"
}

variable "aws_access_key" {
    default = "DELETED"
}
variable "aws_secret_key" {
    default = "DELETED"
  
}
variable "aws_region" {
    description = "Region for VPC"
    default = "us-east-1"
}

variable "aws_ami" {
    description = "AMI for EC2 Instance"
}

variable "aws_public_key" {
    default = "DELETED"
}