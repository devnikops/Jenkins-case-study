resource "aws_security_group" "devops-sg" {
  name        = "devops-sg"
  description = "Allow inbound traffic"

  dynamic "ingress" {
    for_each = [22, 80, 443, 8080, 9000, 3000]
    content {
      description      = "inbound rule for port ${ingress.value}"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Jenkins-master" {
  ami                    = "ami-03bb6d83c60fc5f7c"           # Replace with the AMI ID
  instance_type          = "t2.medium"                        # Instance type you want to launch
  key_name               = "ec2-global-key"                 # Replace with your SSH key pair name
  vpc_security_group_ids = [aws_security_group.devops-sg.id] # Corrected reference to security group ID
  user_data              = templatefile("jenkins-master.sh", {})

  tags = {
    Name = "Jenkins-master"
  }

  root_block_device {
    volume_size = 25
  }
}

resource "aws_instance" "Jenkins-slave" {
  ami                    = "ami-03bb6d83c60fc5f7c"           # Replace with the AMI ID
  instance_type          = "t2.small"                        # Instance type you want to launch
  key_name               = "ec2-global-key"                 # Replace with your SSH key pair name
  vpc_security_group_ids = [aws_security_group.devops-sg.id] # Corrected reference to security group ID
  user_data              = templatefile("jenkins-slave.sh", {})

  tags = {
    Name = "Jenkins-slave"
  }

  root_block_device {
    volume_size = 15
  }
}