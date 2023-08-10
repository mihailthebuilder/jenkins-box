data "aws_ssm_parameter" "jenkins_public_key" {
  name = "/jenkins-box/public-key"
}

data "aws_ssm_parameter" "jenkins_vpc_id" {
  name = "/jenkins-box/vpc/id"
}

data "aws_ssm_parameter" "jenkins_allow_inbound_access_from_ip" {
  name = "/jenkins-box/ip"
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}
