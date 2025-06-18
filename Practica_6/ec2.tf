resource "aws_instance" "ec2_public" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/user_data.sh")
  tags = {
    Name = "ec2_public"
  }

  provisioner "local-exec" {
    command = "echo instancia creada con IP ${aws_instance.ec2_public.public_ip} >> datos_instancia.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo instancia ${self.public_ip} Destruida >> datos_instancia.txt"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "echo 'hello world form remote in write local' >  ~/saludos.txt"
  #   ]

  #   connection {
  #     type        = "ssh"
  #     host        = self.public_ip
  #     user        = "ec2-user"
  #     private_key = file("Edisonw-lab.pem")
  #   }
  # }

  # lifecycle {
  #   # create_before_destroy = true
  #   # prevent_destroy = true
  #   # ignore_changes = [
  #   #   ami,
  #   #   subnet_id
  #   # ]
  #   replace_triggered_by = [
  #     aws_subnet.private_subnet.id
  #   ]
  # }

}


# resource "aws_instance" "mywebserver" {
#   ami           = "ami-02457590d33d576c3"
#   instance_type = "t2.micro"
#   key_name      = data.aws_key_pair.key.key_name
#   subnet_id     = aws_subnet.public_subnet.id
#   tags = {
#     "Name" = "myweb"
#   }
#   vpc_security_group_ids = [
#     aws_security_group.sg_public_instance.id
#   ]
# }
