provider "aws" {
  region = "ap-south-1"  
}

resource "aws_instance" "terraformpro" {
  ami           = "ami-0c55b159cbfafe1f0"  
  instance_type = "t2.micro"  

 subnet_id       = aws_subnet.my_subnet.id
 
vpc_security_group_ids = [aws_security_group.instance_sg.id]

user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              service httpd start
              chkconfig httpd on
              firewall-cmd --zone=public --add-port=80/tcp --permanent
              firewall-cmd --reload
              EOF
  tags = {
    Name = "terraformpro" 
  }
