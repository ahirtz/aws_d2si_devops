variable "aws_region" {
  type    = "string"
  default = "eu-west-1"
}

variable "vpc_cidr" {
  type    = "string"
  default = "172.23.0.0/16"
}

variable "subnet_cidrs_private" {
  type        = "list"
  default     = ["172.23.1.0/24", "172.23.2.0/24"]
  description = "Subnet CIDRs for private subnets (length must match configured availability_zones)"

  # this could be further simplified / computed using cidrsubnet() etc.
  # https://www.terraform.io/docs/configuration/interpolation.html#cidrsubnet-iprange-newbits-netnum-
}
