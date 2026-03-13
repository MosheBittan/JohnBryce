
Task 3: Infrastructure Modularization
•	Refactoring: Convert the VPC and EC2 configurations from Task 1 and 2 into a reusable Terraform module.
•	Variables: The module must allow users to define:
o	VPC CIDR range
o	Subnet count
o	Instance type
o	Public IP assignment (Boolean)
•	Deployment: Call and deploy this module from a separate Terraform root configuration.
