variable "key_name" {
  description = "Desired name of AWS key pair"
  default = "mishra-hashicorp-pub"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "ap-south-1"
}

variable "service_name" {
}

variable "service_port" {
    default = 8080
}

variable "release_url" {
}

variable "vpc_id" {
}

variable "subnet_id" {
}

variable "web_server_count" {
    default = 1
}

variable "instance_type" {
    default = "m5.large"
}

