module "db"{
    source= "../../terraform-aws-securitygroup"
    project_name= var.project_name
    environment= var.environment
    sg_description= var.db_sg_description
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags= var.common_tags
    sg_name = "db"
}

module "backend"{
    source= "../../terraform-aws-securitygroup"
    project_name= var.project_name
    environment= var.environment
    sg_description= "SG for backend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags= var.common_tags
    sg_name = "backend"
}

module "frontend"{
    source= "../../terraform-aws-securitygroup"
    project_name= var.project_name
    environment= var.environment
    sg_description= "Sg for frontend"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags= var.common_tags
    sg_name = "frontend"
}

module "bastion"{
    source= "../../terraform-aws-securitygroup"
    project_name= var.project_name
    environment= var.environment
    sg_description= "Sg for bastion"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags= var.common_tags
    sg_name = "bastion"
}

module "app_alb"{
    source= "../../terraform-aws-securitygroup"
    project_name= var.project_name
    environment= var.environment
    sg_description= "Sg for APP ALB"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags= var.common_tags
    sg_name = "app_alb"
}

module "vpn"{
    source= "../../terraform-aws-securitygroup"
    project_name= var.project_name
    environment= var.environment
    sg_description= "Sg for VPN"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags= var.common_tags
    sg_name = "vpn"
    ingress_rules = var.vpn_sg_rules
}

# db is accpeting connections from backend 
resource "aws_security_group_rule" "db_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id  = module.backend.sg_id  #source is where you are getting traffic from 
  security_group_id = module.db.sg_id
}

# db is accpeting connections from bastion
resource "aws_security_group_rule" "db_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id  = module.bastion.sg_id  #source is where you are getting traffic from 
  security_group_id = module.db.sg_id
}

# db is accpeting connections from vpn
resource "aws_security_group_rule" "db_vpn" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id  = module.vpn.sg_id  #source is where you are getting traffic from 
  security_group_id = module.db.sg_id
}

# backend is accpeting connections from frontend 
resource "aws_security_group_rule" "backend_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id  = module.app_alb.sg_id  #source is where you are getting traffic from 
  security_group_id = module.backend.sg_id
}

# backend is accpeting connections from bastion
resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id  = module.bastion.sg_id  #source is where you are getting traffic from 
  security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "backend_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id  = module.vpn.sg_id  #source is where you are getting traffic from 
  security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "backend_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id  = module.vpn.sg_id  #source is where you are getting traffic from 
  security_group_id = module.backend.sg_id
}



# frontend is accpeting connections from internet
resource "aws_security_group_rule" "frontend_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend.sg_id
}

# frontend is accpeting connections from bastion
resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id  = module.bastion.sg_id  #source is where you are getting traffic from 
  security_group_id = module.frontend.sg_id
}




resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

resource "aws_security_group_rule" "app-alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
 source_security_group_id  = module.vpn.sg_id  #source is where you are getting traffic from 
  security_group_id = module.app_alb.sg_id
}


