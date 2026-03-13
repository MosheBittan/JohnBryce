# Launch Template Resource
resource "aws_launch_template" "my_launch_template" {
  name          = "my_launch_template"
  description   = "My lauch template"
  image_id      = "ami-03d1d24d942df7614"
  instance_type = "t3.micro"

  vpc_security_group_ids = ["sg-03b37b54442426bc8"]
  key_name               = "terraform-key"
  user_data              = filebase64("${path.module}/app1-install.sh")
  ebs_optimized          = true
  #default_version = 1
  update_default_version = true
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 10
      delete_on_termination = true
      volume_type           = "gp2" #default is gp2
    }
  }
  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "myasg"
    }
  }
}
