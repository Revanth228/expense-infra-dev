data "aws_ssm_parameter" "app_alb_sg_id"{
    name= "/${var.project_name}/${var.environment}/app_alb_sg_id"
}

data "aws_ssm_parameter" "private_subnet_id"{
    name= "/${var.project_name}/${var.environment}/private_subnet_id"
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