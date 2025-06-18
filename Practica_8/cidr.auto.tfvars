virginia_cidr = "10.10.0.0/16"

# virginia_cidr = {
#   "prod" = "10.10.0.0/16"
#   "dev"  = "172.10.0.0/16"
# }


# public_subnet  = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"

subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  env         = "dev"
  owner       = "edison"
  IAC         = "terraform"
  IAC_Version = "1.11.4"
  project     = "practic_6"
  team        = "devops"
  cloud       = "aws"
  project     = "company"
  region      = "us-east-1"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  ami           = "ami-0953476d60561c955"
  instance_type = "t2.micro"
}

enable_monitoring = 0

ingress_ports_list = [22, 80, 443]
