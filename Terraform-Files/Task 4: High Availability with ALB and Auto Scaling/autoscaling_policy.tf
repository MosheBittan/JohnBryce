# TTS - Scanling Policy-1: Based on CPU Utilization of EC2 Intances
#Define Autoscaling Policies and Associate them to Autoscaling Group

resource "aws_autoscaling_policy" "avg_cpu_policy_greater_than_50" {
  name                      = "avg-cpu-policy-greater-than-50"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.my_asg.name
  estimated_instance_warmup = 180
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}


# TTS - Scaling Policy-2: Based on ALB Target Requests
resource "aws_autoscaling_policy" "alb_target_requests_greater_than_yy" {
  name                      = "alb-target-requests-greater-than-yy"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.my_asg.name
  estimated_instance_warmup = 120 # Seconds
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${module.alb.arn_suffix}/${module.alb.target_groups["mytg1"].arn_suffix}"
    }
    target_value = 10.0
  }
}