# Download current stable release of Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# Create symbolic link to pick up docker-compose in path.
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Test the installation
docker-compose --version
