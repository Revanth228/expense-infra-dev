variable "project_name"{
type= string
default= "expense"

}

variable "environment"{
    type = string
    default = "dev"
}

variable "common_tags" {
  default = {
    Project = "expense"
    Environment = "dev"
    Terraform = "true"
  }
}

variable "db_sg_description"{
    type = string 
    default= "security group for database mysql instances"
}

variable "zone_name"{
    default = "daws78s-rev.online"
}
