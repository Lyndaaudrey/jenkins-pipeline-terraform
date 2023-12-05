# Server ami

data "aws_ami" "ubuntu_server_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}




# Création key pair

resource "aws_key_pair" "project_auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)

}


#Création server jenkins

 resource "aws_instance" "jenkins_server" {
  ami                    = data.aws_ami.ubuntu_server_ami.id
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.project_auth.id
  vpc_security_group_ids = [aws_security_group.instances_sg.id]
  subnet_id              = aws_subnet.project_public_subnet[0].id
  user_data              = file("./jenkins-setup.sh") 

  root_block_device {
    volume_size = var.main_vol_size
  }

  tags = {
    Name = "Jenkins-server"
  }

} 

#Associatio server jenkins à une adresse ip elastic

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.jenkins_server.id
  allocation_id = "eipalloc-0bf37d8bc49556885"
} 

  

 # Création serveur sonarqube

resource "aws_instance" "sonar_server" {
  ami                    = data.aws_ami.ubuntu_server_ami.id
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.project_auth.id
  vpc_security_group_ids = [aws_security_group.instances_sg.id]
  subnet_id              = aws_subnet.project_public_subnet[0].id
  user_data              = file("./sonar-setup.sh") 

  root_block_device {
    volume_size = var.main_vol_size
  }

  tags = {
    Name = "sonar-server"
  }

}   




