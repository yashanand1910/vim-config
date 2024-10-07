# syntax=docker/dockerfile:1

FROM nvidia/cuda:12.4.1-devel-ubuntu22.04

LABEL org.opencontainers.image.source=https://github.com/yashanand1910/dotfiles

ARG USER=yashanand
ARG UID=1000
ARG DOCKERFILE_DIR
ARG GITHUB_KEY
ARG DOCKERHUB_KEY

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

# Setup NVIDIA container toolkit
RUN <<EOT
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
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

# Setup credentials and env (since image is private)
ADD --chown=${USER}:${USER} .oh-my-zsh/custom/env.zsh .oh-my-zsh/custom/env.zsh
ADD --chown=${USER}:${USER} .ssh .ssh
ADD --chown=${USER}:${USER} .gnupg/public.key .gnupg/public.key
ADD --chown=${USER}:${USER} .gnupg/private.key .gnupg/private.key
RUN <<EOT
gpg --batch --import .gnupg/public.key
gpg --batch --import .gnupg/private.key
echo -e "5\ny\n" | gpg --batch --yes --command-fd 0 --edit-key $(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | cut -d'/' -f2) trust quit
docker login -u yashanand1910 -p ${DOCKERHUB_KEY}
echo ${GITHUB_KEY} > github_key
gh auth login --with-token < github_key
rm github_key
EOT

# Setup dotfiles
RUN <<EOT
git clone git@github.com:yashanand1910/dotfiles.git
mkdir -p .config
chown -R ${USER}:${USER} .config
ln -s /home/${USER}/dotfiles/nvim .config/nvim
ln -s /home/${USER}/dotfiles/.gitconfig .gitconfig
ln -s /home/${USER}/dotfiles/.gitignore .gitignore
ln -s /home/${USER}/dotfiles/.vimrc .vimrc
ln -s /home/${USER}/dotfiles/.zshrc .zshrc
ln -s /home/${USER}/dotfiles/.tmux.conf .tmux.conf
ln -s /home/${USER}/dotfiles/zsh .oh-my-zsh/custom/
EOT

ADD --chown=${USER}:${USER} --chmod=755 code/dotfiles/entrypoint entrypoint

ENTRYPOINT ["./entrypoint"]
