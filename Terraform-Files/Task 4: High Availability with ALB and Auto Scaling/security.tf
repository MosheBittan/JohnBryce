# --------------------------------------------------------
# 2. CREATE THE SECURITY GROUP
# --------------------------------------------------------
resource "aws_security_group" "ec2_sg" {
  name = "ec2_sg"

  # Grab the VPC ID dynamically from the module above!
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [module.alb.security_group_id]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}
