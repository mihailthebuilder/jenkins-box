resource "aws_key_pair" "jenkins_ec2_key_pair" {
  key_name   = "jenkins-ec2-key-pair"
  public_key = data.aws_ssm_parameter.jenkins_public_key.value
}

resource "aws_instance" "jenkins_instance" {
  instance_id            = "ami-0f34c5ae932e6f0e4"
  instance_type          = var.ec2_instance_size_type
  key_name               = aws_key_pair.jenkins_ec2_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]

  root_block_device {
    volume_size = var.ec2_instance_root_volume_size
  }

  ebs_block_device {
    device_name = "jenkins-application-volume"
    size        = var.ec2_instance_application_volume_size
  }
}