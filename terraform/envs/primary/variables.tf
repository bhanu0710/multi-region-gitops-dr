variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "cluster_name" {
  type    = string
  default = "dr-demo-primary"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}
