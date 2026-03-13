################################################################################
# Load Balancer
################################################################################

output "id" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.id
}

output "arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.arn
}

output "arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch"
  value       = module.alb.arn_suffix
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.dns_name
}

output "zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = module.alb.zone_id
}

################################################################################
# Listener(s)
################################################################################

output "listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.alb.listeners
  sensitive   = true
}

output "listener_rules" {
  description = "Map of listeners rules created and their attributes"
  value       = module.alb.listener_rules
  sensitive   = true
}

################################################################################
# Target Group(s)
################################################################################

output "target_groups" {
  description = "Map of target groups created and their attributes"
  value       = module.alb.target_groups
}

# output "target_groups_arns" {
#   description = "ARNs of target groups created and their attributes"
#   value       = module.alb.target_groups_arns
# }

################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.alb.security_group_arn
}

# output "security_group_id" {
#   description = "ID of the security group"
#   value       = module.alb.security_group_id
# }


################################################################################
# ASG
################################################################################

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.my_launch_template.id
}

output "launch_template_latest_version" {
  description = "Launch Template Latest Version"
  value       = aws_launch_template.my_launch_template.latest_version
}

output "autoscaling_group_id" {
  description = "Autoscaling group ID"
  value       = aws_autoscaling_group.my_asg.id
}

output "autoscaling_group_name" {
  description = "Autoscaling group Name"
  value       = aws_autoscaling_group.my_asg.name
}

output "autoscaling_group_arn" {
  description = "Autoscaling group Name"
  value       = aws_autoscaling_group.my_asg.arn
}