resource "aws_key_pair" "jenkins_ec2_key_pair" {
  key_name   = "jenkins-ec2-key-pair"
  public_key = data.aws_ssm_parameter.jenkins_public_key.value
}

resource "aws_instance" "jenkins_instance" {
  ami                    = data.aws_ssm_parameter.ubuntu_20_ami_id.value
  instance_type          = var.ec2_instance_size_type
  key_name               = aws_key_pair.jenkins_ec2_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]

  user_data = templatefile("init.sh", {
    email : data.aws_ssm_parameter.jenkins_certbot_email.value,
    domain : data.aws_ssm_parameter.subdomain.value,
  })
}

resource "aws_ebs_volume" "jenkins_additional_storage" {
  availability_zone = "${var.region}a"
  size              = var.ec2_instance_additional_storage_size
  encrypted         = true
}

resource "aws_volume_attachment" "jenkins_additional_storage_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.jenkins_additional_storage.id
  instance_id = aws_instance.jenkins_instance.id
}

resource "aws_route53_record" "jenkins_site_subdomain" {
  zone_id = data.aws_ssm_parameter.domain_route53_zone_id.value
  name    = data.aws_ssm_parameter.subdomain.value
  type    = "A"
  ttl     = 60
  records = [aws_instance.jenkins_instance.public_ip]
}
