module "vpc" {
  source = "./modules/networking"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "13-local-modules"
  }
  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "eu-north-1a"
      public     = false
    }

    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      az         = "eu-north-1b"
      # Public subnets are indicated by setting the "public" option to true
      public = true
    }
  }
}