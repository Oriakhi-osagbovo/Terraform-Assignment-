resource "aws_instance" "instance" {
  count         = var.azs
  ami           = var.environments[each.value.environment].ami
  instance_type = var.environments[each.value.environment]instance_type
  availability_zone = var.azs[count.index]
  vpc_id        = module.vpc.vpc_id


  tags = {
    Environmnet = each.value.environment
  }
}