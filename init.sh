#!/bin/bash -xe

sudo -i

# Update packages
apt-get update; apt-get full-upgrade -y; apt-get autoclean -y;

# Install Java
apt-get install openjdk-17-jdk openjdk-17-jre -y

# Import key file from Jenkins-CI to enable installation from package
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repo
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
apt-get update -y
apt-get install jenkins -y

# Enable Jenkins to start at boot
systemctl enable jenkins

# Start Jenkins as a service
systemctl start jenkins