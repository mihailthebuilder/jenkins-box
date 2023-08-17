#!/bin/bash -xe

sudo -i

# Update packages
apt-get update; apt-get full-upgrade -y; apt-get autoclean -y;

### Forward traffic from HTTP(S) ports to the Jenkins ports

# # Install nftables
# apt-get install nftables -y

# # Create routing ruleset file
# cat <<EOF > nft_rules.nft
# table ip nat {
#     chain prerouting {
#         type nat hook prerouting priority 0; policy accept;
#         tcp dport 80 log prefix "HTTP: "  redirect to :8080
#         tcp dport 443  log prefix "HTTPS: "  redirect to :8080
#     }
# }
# EOF

# cat > $nginx_config_path <<EOF
# server {
#     listen 443;
#     server_name pipeline.employerintel.com;

#     location / {
#         proxy_pass http://127.0.0.1:8080;
#         proxy_set_header Host $host;
#         proxy_set_header X-Real-IP $remote_addr;
#         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#         proxy_set_header X-Forwarded-Proto $scheme;    }
# }

# EOF

# # Load ruleset
# nft -f nft_rules.nft

# # Save ruleset so it works after reboot
# nft list ruleset > /etc/nftables.conf

### Set up Jenkins

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