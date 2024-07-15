FROM ubuntu:22.04

LABEL org.opencontainers.image.source https://github.com/yashanand1910/dotfiles

# Install packages
RUN <<EOT
apt-get update
apt-get install -y openssh-client
apt-get install -y git
apt-get install -y zsh
apt-get install -y wget
rm -rf /var/lib/apt/lists/*
EOT

# Install zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --skip-chsh --unattended --keep-zshrc

# Setup user
ARG USER=yashanand
ARG UID=1000
RUN useradd -rm -d /home/${USER} -s /bin/zsh -G sudo -u ${UID} -g root ${USER}
USER ${USER}
WORKDIR /home/${USER}

# Setup dotfiles
RUN mkdir -p .config
COPY nvim .config/nvim
COPY .gitconfig .gitconfig
COPY .vimrc .vimrc
COPY .zshrc .zshrc
COPY .tmux.conf .tmux.conf

ENTRYPOINT ["/bin/zsh"]
