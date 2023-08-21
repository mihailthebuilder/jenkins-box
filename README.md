# Jenkins on AWS EC2 using Terraform

Terraform scripts that deploy a Jenkins server on AWS EC2.

## Architecture diagram

TODO

## Setup

### 1. Backend

Configure the `backend` in the [provider.tf](./provider.tf) file, which stores the state of your infrastructure.
If you decide to keep the backend in S3, remember to create the bucket beforehand; ideally, you should also
enable [bucket versioning](https://docs.aws.amazon.com/AmazonS3/latest/userguide/manage-versioning-examples.html)
to allow for state recovery in case of any mistakes.

### 2. Domain

Register a domain with your preferred domain registrar, then set up a hosted zone in Route 53. Copy the 


## Technical choices



iptables instead of Nginx and the likes - simplicity
iptables instead of Elastic Load Balancer - simplicity and cost

ubuntu instead of amazon linux - doesn't support Extra Packages for Enterprise Linux (EPEL)