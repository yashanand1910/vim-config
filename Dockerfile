FROM ubuntu:22.04

LABEL org.opencontainers.image.source https://github.com/yashanand1910/dotfiles

# Install packages
RUN <<EOT
apt-get update
apt-get install -y build-essential
apt-get install -y git
apt-get install -y zsh
apt-get install -y wget
apt-get install -y curl
apt-get install -y sudo
apt-get install -y unzip
apt-get install python3.11
apt-get install python3-pip
apt-get install -y gpg
apt-get install -y man-db
EOT

# Setup user
ARG USER=yashanand
ARG UID=1000
RUN groupadd -g 1000 {USER}
RUN useradd -rm -d /home/${USER} -s /bin/zsh -u ${UID} -g root ${USER} -G ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}

# Setup zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --skip-chsh --unattended --keep-zshrc
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/loiccoyle/zsh-github-copilot ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-github-copilot
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --key-bindings --completion --no-update-rc
ENV TERM=xterm-256color

# Setup tmux
RUN <<EOT
sudo apt-get install -y tmux
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
EOT

# Setup neovim
RUN <<EOT
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz
EOT

# Setup node (for nvim plugins)
RUN <<EOT
curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
sudo -E bash nodesource_setup.sh
sudo apt-get install -y nodejs
rm nodesource_setup.sh
EOT

# Setup miscelaneous
RUN <<EOT
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
sudo apt-get install -y ripgrep
EOT

# Setup dotfiles
RUN mkdir -p .config
COPY nvim .config/nvim
COPY .gitconfig .gitconfig
COPY .vimrc .vimrc
COPY .zshrc .zshrc
COPY .tmux.conf .tmux.conf
COPY zsh .oh-my-zsh/custom/

ENTRYPOINT ["/bin/zsh"]
