# dotfiles

Hosts my zsh, vim, tmux & kitty configuration for sync across hosts.

## Create symlinks

After cloning this repository, create the symlinks

```bash
ln -s ~/work/dotfiles/.vimrc ~/.vimrc
ln -s ~/work/dotfiles/config.lua ~/.config/lvim/config.lua
ln -s ~/work/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/work/dotfiles/colors ~/.vim/colors
ln -s ~/work/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/work/dotfiles/.zshrc ~/.zshrc
ln -s ~/work/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
```

## Install oh-my-zsh

```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Install vim-plug (if using vim)

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```   
```bash
:PlugInst
```
