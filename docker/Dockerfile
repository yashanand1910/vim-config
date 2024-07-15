FROM ubuntu:22.04

# Install packages
RUN <<EOT
apt-get update
apt-get install -y openssh-client
rm -rf /var/lib/apt/lists/*
EOT

ENTRYPOINT ["/bin/bash"]
