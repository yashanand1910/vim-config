FROM ubuntu:22.04

LABEL org.opencontainers.image.source https://github.com/yashanand1910/dotfiles

# Install packages
RUN <<EOT
apt-get update
apt-get install -y openssh-client
apt-get install -y git
apt-get install -y zsh
apt-get install -y wget
apt-get install -y sudo
rm -rf /var/lib/apt/lists/*
EOT

# Setup user
ARG USER=yashanand
ARG UID=1000
RUN useradd -rm -d /home/${USER} -s /bin/zsh -G sudo -u ${UID} -g root ${USER}
USER ${USER}
WORKDIR /home/${USER}

# Setup zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --skip-chsh --unattended --keep-zshrc
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/loiccoyle/zsh-github-copilot ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-github-copilot
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --key-bindings --completion --no-update-rc
RUN <<EOT
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
EOT

# Setup dotfiles
RUN mkdir -p .config
COPY nvim .config/nvim
COPY .gitconfig .gitconfig
COPY .vimrc .vimrc
COPY .zshrc .zshrc
COPY .tmux.conf .tmux.conf

ENTRYPOINT ["/bin/zsh"]
