# Zone ID of the AWS Route53 Zone (here or via command line)
variable "aws_route53_zone" {
  type        = string
  description = "My R53 Zone ID"
}

# Optional domain name setting. This will be appended to the end of the `Name` tag.
variable "domain" {
  type    = string
  default = "noperightout.io"
}

# How many instances to create. Defaults to 2
variable "num_instances" {
  default = 1
}
