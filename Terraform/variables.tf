
variable "aws_regions" {
  type = map(string)
  default = {
    dev = "eu-west-1"
    prod = "eu-central-1"
  }
}

variable "azs" {
  type = list(string)
  default = ["eu-west-1a", "eu-west-1b"]
}

variable "environments" {
  type = map(object({
    ami = string
    instance_type = string
  }))
  default = {
    dev = {
      ami = "ami-038d7b856fe7557b3"
      instance_type = "t2.micro"
    }
    prod = {
      ami = "ami-038d7b856fe7557b3"
      instance_type = "t3.micro"
    }
  }
}