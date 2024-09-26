FROM nvidia/cuda:12.4.1-base-ubuntu22.04

LABEL org.opencontainers.image.source https://github.com/yashanand1910/dotfiles

# Install packages
RUN <<EOT
set -eux
apt-get update
apt-get install -y build-essential
apt-get install -y git
apt-get install -y zsh
apt-get install -y wget
apt-get install -y curl
apt-get install -y sudo
apt-get install -y unzip
apt-get install -y python3-pip
apt-get install -y python3-venv
apt-get install -y gpg
apt-get install -y net-tools lsof
apt-get install -y locales
apt-get install -y man-db
yes | unminimize
EOT

# Set locale
RUN <<EOT
set -eux
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
EOT

# Setup docker (CLI only for docker-in-docker)
RUN <<EOT
set -eux
apt-get install -y ca-certificates
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
    https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$UBUNTU_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce-cli
EOT

# Setup user
ARG USER=yashanand
ARG UID=1000
RUN <<EOT
set -eux
groupadd -g 1000 ${USER}
useradd -rm -d /home/${USER} -s /bin/zsh -u ${UID} -g ${USER} -G sudo ${USER}
echo "${USER} ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/${USER}
EOT
USER ${USER}
WORKDIR /home/${USER}

# Setup zsh
RUN <<EOT
set -eux
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --skip-chsh --unattended --keep-zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/loiccoyle/zsh-github-copilot ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-github-copilot
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc
echo "export PATH=\$PATH:/home/${USER}/.local/bin" >> ~/.oh-my-zsh/custom/env.zsh
rm ~/.oh-my-zsh/custom/example.zsh
EOT
ENV TERM=xterm-256color

# Setup tmux
RUN <<EOT
set -eux
sudo apt-get install -y tmux
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
EOT

# Setup neovim
RUN <<EOT
set -eux
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz
EOT

# Setup node (for nvim plugins)
RUN <<EOT
set -eux
curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
sudo -E bash nodesource_setup.sh
sudo apt-get install -y nodejs
rm nodesource_setup.sh
EOT

# Setup github CLI
RUN <<EOT
set -eux
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
EOT

# Setup go
RUN <<EOT
set -eux
wget https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
rm go1.22.5.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.oh-my-zsh/custom/env.zsh
EOT

# Setup miscelaneous
RUN <<EOT
set -eux
sudo apt-get install -y ripgrep
EOT

# Setup dotfiles
RUN mkdir -p .config
RUN chown -R ${USER}:${USER} .config
COPY --chown=${USER}:${USER} nvim .config/nvim
COPY --chown=${USER}:${USER} .gitconfig .gitconfig
COPY --chown=${USER}:${USER} .gitignore .gitignore
COPY --chown=${USER}:${USER} .vimrc .vimrc
COPY --chown=${USER}:${USER} .zshrc .zshrc
COPY --chown=${USER}:${USER} .tmux.conf .tmux.conf
COPY --chown=${USER}:${USER} zsh .oh-my-zsh/custom/

COPY --chown=${USER}:${USER} --chmod=755 entrypoint /home/${USER}/entrypoint

ENTRYPOINT ["./entrypoint"]
