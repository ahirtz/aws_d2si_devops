output "aws_vpc_main_id" {
  value       = "${aws_vpc.main.id}"
  description = "The id of the main VPC"
}

output "aws_subnets_ids" {
  value       = "${aws_subnet.subnets.*.id}"
  description = "The ids of the private subnets"
}
