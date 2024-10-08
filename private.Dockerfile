# syntax=docker/dockerfile:1

FROM yashanand1910/dev:latest

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
mkdir code
cd code
git clone git@github.com:yashanand1910/dotfiles.git
cd -
mkdir -p .config
chown -R ${USER}:${USER} .config
ln -sf /home/${USER}/code/dotfiles/nvim .config/nvim
ln -sf /home/${USER}/code/dotfiles/.gitconfig .gitconfig
ln -sf /home/${USER}/code/dotfiles/.gitignore .gitignore
ln -sf /home/${USER}/code/dotfiles/.vimrc .vimrc
ln -sf /home/${USER}/code/dotfiles/.zshrc .zshrc
ln -sf /home/${USER}/code/dotfiles/.tmux.conf .tmux.conf
ln -sf /home/${USER}/code/dotfiles/zsh/* .oh-my-zsh/custom/
EOT

ADD --chown=${USER}:${USER} --chmod=755 code/dotfiles/entrypoint entrypoint

ENTRYPOINT ["./entrypoint"]
