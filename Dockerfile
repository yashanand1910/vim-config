FROM ubuntu:22.04

LABEL org.opencontainers.image.source https://github.com/yashanand1910/dotfiles

# Install packages
RUN <<EOT
apt-get update
apt-get install -y openssh-client
apt-get install -y git
rm -rf /var/lib/apt/lists/*
EOT

# Setup user
ARG USER=yashanand
ARG UID=1000
RUN useradd -rm -d /home/${USER} -s /bin/bash -G sudo -u ${UID} -g root ${USER}
USER ${USER}
WORKDIR /home/${USER}

ENTRYPOINT ["/bin/bash"]
