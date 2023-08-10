variable "region" {
  default = "us-east-1"
}

variable "ec2_instance_size_type" {
  default = "t4g.medium"
}

variable "ec2_instance_root_volume_size" {
  default = 8
}


variable "ec2_instance_application_volume_size" {
  default = 20
}