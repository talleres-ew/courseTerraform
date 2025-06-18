variable "instances" {
  description = "Name of the instances"
  # type        = set(string)
  type    = list(string)
  default = ["apache", "mysql"]
  # default = ["apache", "jumpserver", "mysql"]
}

#tfsec:ignore:aws-ec2-enable-at-rest-encryption
resource "aws_instance" "ec2_public" {
  # count                  = length(var.instances)
  for_each               = toset(var.instances)
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/user_data.sh")
  tags = {
    Name = "${each.value}-${local.sufix}"
    # Name = var.instances[count.index]
  }
}

# resource "aws_instance" "ec2_monitoring" {
#   count                  = var.enable_monitoring != 1 ? 1 : 0
#   ami                    = var.ec2_specs.ami
#   instance_type          = var.ec2_specs.instance_type
#   subnet_id              = aws_subnet.public_subnet.id
#   key_name               = data.aws_key_pair.key.key_name
#   vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
#   user_data              = file("scripts/user_data.sh")
#   tags = {
#     Name = "Monitor"
#   }
# }
