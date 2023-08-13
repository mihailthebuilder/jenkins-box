# Terraform / Jenkins / AWS EC2

Terraform scripts that deploy a Jenkins server on AWS EC2.

## Choices

iptables instead of Nginx and the likes - simplicity
iptables instead of Elastic Load Balancer - simplicity and cost

ubuntu instead of amazon linux - doesn't support Extra Packages for Enterprise Linux (EPEL)