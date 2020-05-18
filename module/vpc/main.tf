//CREATING VPC
resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support = "${var.enable_dns_support}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  tags = {
      Name = "${var.title}-${var.env_tag}-vpc"
      Environment = "${var.env_tag}"
  }
}

//CREATE INTERNET GATEWAY
resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.main.id}"
    tags = {
        Name = "${var.title}-${var.env_tag}-igw"
        Environment = "${var.env_tag}"
    } 
}

//CREATE PUBLIC SUBNET
resource "aws_subnet" "main_public" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "${var.az}"
    map_public_ip_on_launch = "${var.namemap_public_ip_on_launch}"
    tags = {
        Name = "${var.title}-${var.env_tag}-public-subnet"
        Environment = "${var.env_tag}"
    }
}

//CREATE PRIVATE SUBNET
resource "aws_subnet" "main_private" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "${var.az}"
    //map_public_ip_on_launch = "${var.namemap_public_ip_on_launch}"
    tags = {
        Name = "${var.title}-${var.env_tag}-private-subnet"
        Environment = "${var.env_tag}"
    }
}

//CREATE PUBLIC ROUTE TABLE
resource "aws_route_table" "rt_public" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }
    tags = {
        Name = "${var.title}-${var.env_tag}-public-rt"
        Environment = "${var.env_tag}"
    }
}

//CREATE PUBLIC ROUTE TABLE
resource "aws_route_table" "rt_private" {
    vpc_id = "${aws_vpc.main.id}"
    tags = {
        Name = "${var.title}-${var.env_tag}-private-rt"
        Environment = "${var.env_tag}"
    }
}


//MAP PUBLIC ROUTE TABLE TO PUBLIC SUBNET
resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.main_public.id}"
  route_table_id = "${aws_route_table.rt_public.id}"
}

//MAP PRIVATE ROUTE TABLE TO PRIVATE SUBNET
resource "aws_route_table_association" "private" {
  subnet_id = "${aws_subnet.main_private.id}"
  route_table_id = "${aws_route_table.rt_private.id}"
}

//CREATE EIP FOR NAT

//CREATE NAT GATEWAY

//CREATE RESOURCE GROUP
resource "aws_security_group" "allow_ports" {
    name = "${var.title}-${var.env_tag}-sg"
    description = "Set Inbound and Outbound rules"
    vpc_id = "${aws_vpc.main.id}"
    ingress {
        description = "Allow Traffic from ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Allow Traffic for Security Group Itself"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.title}-${var.env_tag}-sg"
        Environment = "${var.env_tag}"
    }
}

