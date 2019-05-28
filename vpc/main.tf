provider "aws" {
  region  = "${var.aws_region}"
  version = "~> 2.0"
}

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"

  tags = {
    Name = "aws_vpc_main"
  }
}

resource "aws_subnet" "subnets" {
  count      = "${length(var.subnet_cidrs_private)}"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_cidrs_private[count.index]}"

  tags = {
    Name = "aws_subnet_${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "aws_igw"
  }
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "aws_route_table"
  }
}

resource "aws_route_table_association" "a" {
  count          = "${length(var.subnet_cidrs_private)}"
  subnet_id      = "${element(aws_subnet.subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.r.id}"
}
