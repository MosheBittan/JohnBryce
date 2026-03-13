module "web_server" {
  source = "./modules/compute"

  # Iterate over the map of public subnets
  for_each = module.vpc.public_subnets

  # Hardware settings
  ami_id        = each.key == "subnet_1" ? "ami-025d7bea93113b6cc" : "ami-03d1d24d942df7614"
  instance_type = "t3.micro"

  # Dynamically name the servers to avoid identical tags in AWS
  # Example output: "web_server-subnet_1", "web_server-subnet_2"
  server_name = "web_server-${each.key}"

  # THE MAGIC HANDSHAKE:
  # Dynamically pulls the specific subnet ID for the current iteration
  subnet_id          = each.value.subnet_id
  security_group_ids = [aws_security_group.ec2_sg.id]
  is_public          = true
}