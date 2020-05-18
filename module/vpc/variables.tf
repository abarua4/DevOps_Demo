variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
    default = "10.0.2.0/24"
}

variable "region" {
    default = "us-east-1"
}
variable "az" {
    default = "us-east-1a"
}


variable "env_tag" {
    default = "DEV"
}

variable "namemap_public_ip_on_launch" {
    default = "true"
}

variable "enable_dns_support" {
    default = "true"
}

variable "enable_dns_hostnames" {
    default = "true"
}

variable "title" {
    default = "Terraform"
}