# Let's get the private IP Addresses for the 10.0.0.0/24 Subnet
output "private_ip" {
  value = aws_instance.www[*].private_ip
}

output "hostname" {
  value = aws_instance.www[*].tags["Name"]
}

# Let's get the subnet ID for the 10.0.1.0/24 Subnet
output "subnet_id_ten_one" {
  value = aws_network_interface.ten_one[*].subnet_id
}


# Let's get the subnet ID Addresses for the 10.0.0.0/24 Subnet
output "subnet_id_ten_zero" {
  value = aws_network_interface.ten_zero[*].subnet_id
}


output "private_ip_ten_one" {
  value = aws_network_interface.ten_one[*].private_ip
}


# Let's get the subnet ID Addresses for the 10.0.0.0/24 Subnet
output "private_ip_ten_zero" {
  value = aws_network_interface.ten_zero[*].private_ip
}
