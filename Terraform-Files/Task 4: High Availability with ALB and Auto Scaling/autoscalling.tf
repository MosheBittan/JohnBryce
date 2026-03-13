# Autoscaling Group Resource

resource "aws_autoscaling_group" "my_asg" {
  name_prefix         = "myasg-"
  desired_capacity    = 2
  max_size            = 3
  min_size            = 2
  vpc_zone_identifier = [for s in module.vpc.public_subnets : s.subnet_id]

  #Connect the ASG to ALB:
  # THIS is what automatically registers your new instances to the Load Balancer
  target_group_arns = [module.alb.target_groups["mytg1"].arn]
  health_check_type = "EC2"
  #health_check_grace_period = 300 #  default is 300 seconds

  # Associate Launch Template to ASG:
  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = aws_launch_template.my_launch_template.latest_version
  }

  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      #instance_warmup = 300 # Default behavior is to use the Auto Scaling Groups health check grace period value
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"] # YOu can add any argument from ASG here,if thos has changes, ASG Instance Refresh will trigger
  }
  tag {
    key                 = "Owners"
    value               = "Moshe"
    propagate_at_launch = true
  }
}
