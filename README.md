# <div style="text-align: left; float: left">Terraform Testing</div><div style="text-align: right">01/30/2022</div>

## main.tf

---

### AWS Rules

---

Since we have to build in the same order as if we were building manually, we need to create a few things to support our environment.

- Create VPC
- Create a Subnet for the VPC
- Create the Instance Network Interfaces
- Create the instance, assigning the network interface defaulted to `AL2` and `t2.micro`
- Create the Route53 Record for the instance(s): You'll need to specify your one zone here.
- `terraform [plan|apply] -var aws_route_53_record=<YOUR ZONE ID>`

## variables.tf

---

Here is a very small section for defining three data bits.

- `domain` - This is the default domain name. *Note*: This only affects the EC2 Tag right now... It does nothing for Route53.
- `num_instances` - How many of these EC2 hosts to build in this VPC. Default is 2.
- `aws_route_53_record` - This is the Zone ID for your R53 domain.

## outputs.tf

---

Currently empty. Building off of this to do things like use the `domain` variable to lookup the zone id, to make this even more dynamic.

## Manual Steps

---

- Want to create EC2 instance, need VPC
- Want to create VPC, need EIP
- Created EIP 3.xxx.xxx.xxx
- Created VPC vpc-02xxxxxxxcede
- Needed new IAM Role: removed old accounts and added new account.
- Created new Key Pair
