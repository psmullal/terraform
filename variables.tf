variable "aws_route53_zone" {
  type        = string
  description = "My R53 Zone ID"
}

variable "domain" {
  type    = string
  default = "noperightout.io"
}

variable "num_instances" {
  default = 2
}
