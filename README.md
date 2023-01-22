## dotfiles
Hosts my zsh, vim, tmux & alacritty configuration for sync across hosts.

### Create symlinks
After cloning this repository, create the symlinks
```
ln -s ~/work/dotfiles/_vimrc ~/.vimrc (if using vim)
ln -s ~/work/dotfiles/_lvim_config.lua ~/.config/lvim/config.lua (if using lvim)
ln -s ~/work/dotfiles/_gitconfig ~/.gitconfig
ln -s ~/work/dotfiles/colors ~/.vim/colors
ln -s ~/work/dotfiles/_tmux.conf ~/.tmux.conf
ln -s ~/work/dotfiles/_zshrc ~/.zshrc
ln -s ~/work/dotfiles/_alacritty.yml ~/.config/alacritty/alacritty.yml
```

### Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Install [vim-plug](https://github.com/junegunn/vim-plug) (if using vim)
```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
```shell
:PlugInst
```
