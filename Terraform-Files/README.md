Steps for implementation:
1. Deploy VPC and Subnet
2. Deploy Internet Gateway and associated with vpc
3. Setup a route table with a route to IGW and associate it with subnet
4. Deploy EC2 instance of created subnet
5. Associated a public IP and security group that allow public ingress [http and ssh]
6. output public ip of the EC2 after creating 
