locals {
  name = "my-project" # Add this line
  common_tags = {
    Terraform   = "True"
    Environment = "Prod"
  }
}
# --------------------------------------------------------
# 1. CREATE THE VPC
# --------------------------------------------------------
module "vpc" {
  source = "./modules/networking"

  # You pass in the required network configurations here
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "Task13-VPC"
  }
  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.1.0/24"
      az         = "eu-north-1a"
      public     = true
    }

    subnet_2 = {
      cidr_block = "10.0.2.0/24"
      az         = "eu-north-1b"
      public     = true
    }
  }
}

# --------------------------------------------------------
# 1. CREATE THE ALB
# --------------------------------------------------------

##Configure##
# ALB
# Target Groups
# Load Balancer Target Group Attachment
# Listeners
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.0"

  name               = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = [for subnet in module.vpc.public_subnets : subnet.subnet_id]
  security_groups    = [module.alb.security_group_id]
  # Add this line to disable deletion protection
  enable_deletion_protection = false

  security_group_ingress_rules = {
    allow_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic from the internet"
      cidr_ipv4   = "0.0.0.0/0"
    }
    allow_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic from the internet"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  # Ensure the ALB can send traffic to the EC2 instances
  security_group_egress_rules = {
    allow_vpc_outbound = {
      ip_protocol = "-1"
      cidr_ipv4   = module.vpc.vpc_cidr_block
      # Your VPC CIDR
      description = "Allow ALB to route traffic to VPC"
    }
  }
  tags = merge(local.common_tags, {
    Name = "NLB-Example"
  })

  # Listeners of ALB
  listeners = {
    # Listener-1: my-http-listener
    my-https-listener = {
      port            = 80
      protocol        = "HTTP"
      # certificate_arn = ""

      forward = {
        target_group_key = "mytg1"
      }
    } # end of my-http-listener
  }   # End Of Listeners Block

  target_groups = {
    mytg1 = {
      # if not autoscalling group you have set this false next line
      create_attachment                 = false
      name_prefix                       = "mytg1-"
      protocol                          = "HTTPS"
      port                              = 443
      target_type                       = "instance"
      deregistration_dely               = 10
      load_balancing_cross_zone_enabled = false
      protocol_version                  = "HTTP1"


      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTPS"
        matcher             = "200-399"
      }
      tags = local.common_tags
    } # End of Target Group: mytg1
  }   # END of Target Groups Block
}     # END of ALB


# resource "aws_lb_target_group_attachment" "mytg1" {
#   for_each         = { for k, v in module.web_server : k => v }
#   target_group_arn = module.alb.target_groups["mytg1"].arn
#   target_id        = each.value.instance_id
#   port             = 443

#   # k = ec2_instance
#   # v = ec2_isntance_details
# }

## Temp App Outputs
# output "zz_ec2_private" {
#   value = { for ec2_instance, ec2_intance_details in module.web_server : ec2_instance => ec2_intance_details }
# }

