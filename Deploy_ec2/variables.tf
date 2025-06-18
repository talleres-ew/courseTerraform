variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
}

variable "subnets" {
  description = "Subnets List"
  type        = list(string)
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "ec2_specs" {
  description = "Parameters for ec2"
  type        = map(string)
}

variable "enable_monitoring" {
  description = "Enable monitoring for EC2 instance"
  type        = number
  # type        = bool
}

variable "ingress_ports_list" {
  description = "List of port for ingress rules"
  type        = list(number)
}


# variable "cadena" {
#   type    = 
#   default = "ami-123,AMI-AAV,ami-456"
# }

# variable "palabras" {
#   type    = list(string)
#   default = ["hola", "como", "estan"]
# }

# variable "entornos" {
#   type = map(string)
#   default = {
#     "prod" = "10.10.0.0/16"
#     "dev"  = "172.10.0.0/16"
#   }
# }
