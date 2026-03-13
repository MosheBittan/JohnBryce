# # --------------------------------------------------------
# # 1. CREATE THE NETWORK
# # --------------------------------------------------------
# module "vpc" {
#   source = "./modules/networking"

#   # You pass in the required network configurations here
#   vpc_config = {
#     cidr_block = "10.0.0.0/16"
#     name       = "Task13-VPC"
#   }
#   subnet_config = {
#     subnet_2 = {
#       cidr_block = "10.0.1.0/24"
#       az         = "eu-north-1b"
#       public     = true
#     }
#   }
# }

# # --------------------------------------------------------
# # 2. CREATE THE SECURITY GROUP
# # --------------------------------------------------------
# resource "aws_security_group" "web_sg" {
#   name   = "web-server-sg"

#   # Grab the VPC ID dynamically from the module above!
#   vpc_id = module.vpc.vpc_id 

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#     ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# # --------------------------------------------------------
# # 3. CREATE THE EC2 INSTANCE (Using your new module)
# # --------------------------------------------------------
# module "web_server" {
#   source = "./modules/compute"

#   # Hardware settings
#   ami_id = "ami-025d7bea93113b6cc"
#   instance_type = "t3.micro"
#   server_name   = "My-First-Modular-Server"

#   # THE MAGIC HANDSHAKE:
#   # Passing the outputs from the VPC and Security Group directly into the EC2 module
#   subnet_id          = module.vpc.public_subnets["subnet_2"].subnet_id
#   security_group_ids = [aws_security_group.web_sg.id]
# }

# module "web_server_nginx" {
#   source = "./modules/compute"

#   # Hardware settings
#   ami_id = "ami-03d1d24d942df7614"
#   instance_type = "t3.micro"
#   server_name   = "My-First-Modular-Server"
#   is_public = true
#   # THE MAGIC HANDSHAKE:
#   # Passing the outputs from the VPC and Security Group directly into the EC2 module
#   subnet_id          = module.vpc.public_subnets["subnet_2"].subnet_id
#   security_group_ids = [aws_security_group.web_sg.id]
# }