# Terraform Testing

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

## How to do this thing?!

---

After pulling this repo, getting your Zone id ready, you can run the follwing"
`terraform init`
`terraform plan` - Ensure everything looks good.
`terraform apply` - If you wish for terraform to prompt you for the zone identifier.
-- OR --
`terraform apply -var domain=yourdomain.com -var aws_route_53_record=yourzoneid`

This process took about 7 minutes to run.

You can also update the num_instances value and see the ec2 host count increase or decrease. 
e.g. `terraform apply -var domain=yourdomain.com -var aws_route_53_record=yourzoneid -var num_instances=8` will only add 6 more hosts. Once that completes, `terraform apply -var domain=yourdomain.com -var aws_route_53_record=yourzoneid -var num_instances=5` will remove 3. 
In the console, you can check the work by opening the EC2 page, the VPC page, and the Route53 page. You'll see the hosts get added/removed. 

**Note**: these hosts are all named db0<x> where `x` is just an increment. If you add more than 10, the leading zero will not be removed. I am still working on that one.

## Manual Steps

---

Running these steps manually, creating only a single EC2 instance, took about 30 minutes. 
- Want to create EC2 instance, need VPC
- Want to create VPC, need EIP
- Created EIP 3.xxx.xxx.xxx
- Created VPC vpc-02xxxxxxxcede
- Needed new IAM Role: removed old accounts and added new account.
- Created new Key Pair
