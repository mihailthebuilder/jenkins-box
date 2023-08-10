resource "aws_security_group" "jenkins_security_group" {
  name   = "jenkins-security-group"
  vpc_id = data.aws_ssm_parameter.jenkins_vpc_id.value

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_web_access" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [data.aws_ssm_parameter.jenkins_allow_inbound_access_from_ip.value]
  security_group_id = aws_security_group.jenkins_security_group.id
}

resource "aws_security_group_rule" "allow_ssh_access" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [data.aws_ssm_parameter.jenkins_allow_inbound_access_from_ip.value]
  security_group_id = aws_security_group.jenkins_security_group.id
}