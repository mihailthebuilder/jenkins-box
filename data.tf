data "aws_ssm_parameter" "jenkins_public_key" {
  name = "/jenkins-box/public-key"
}

data "aws_ssm_parameter" "jenkins_vpc_id" {
  name = "/jenkins-box/vpc/id"
}

data "aws_ssm_parameter" "jenkins_allow_inbound_access_from_ip" {
  name = "/jenkins-box/ip"
}