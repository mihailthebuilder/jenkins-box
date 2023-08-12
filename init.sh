#!/bin/bash -xe

sudo -i

# Update packages
yum update -y

# Add Jenkins repo
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import key file from Jenkins-CI to enable installation from package
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade

# Install Java
dnf install java-11-amazon-corretto -y

# Install Jenkins
yum install jenkins -y

# Enable Jenkins to start at boot
systemctl enable jenkins

# Start Jenkins as a service
systemctl start jenkins

# Install iptables
yum install iptables-services -y
systemctl enable iptables
systemctl start iptables

# Allow traffic to HTTP(S) and Jenkins ports
iptables -I INPUT 1 -p tcp --dport 8443 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 8080 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 443 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT

# Forward traffic from HTTP(S) ports to the Jenkins ports
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8443