variable "vpc_cidr" {
  type    = string
  default = "10.123.0.0/16"
}

variable "public_cidrs" {
  type    = list(string)
  default = ["10.123.1.0/24", "10.123.3.0/24"]
}

variable "private_cidrs" {
  type    = list(string)
  default = ["10.123.5.0/24", "10.123.7.0/24"]
}



variable "main_vol_size" {
  type    = number
  default = 8
}




variable "key_name" {
  type = string
}

variable "public_key_path" {
  type = string

}

