data "aws_ssm_parameter" "vpn_sg_id"{
    name= "/${var.project_name}/${var.environment}/vpn_sg_id"
}

data "aws_ssm_parameter" "public_subnet_id"{
    name= "/${var.project_name}/${var.environment}/public_subnet_id"
}

data "aws_ami" "AMI_info" {
 
  most_recent      = true
  owners           = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "default_vpc" {
    default = true

}