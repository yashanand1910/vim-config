## Config
Hosts my zsh, vim, tmux & alacritty configuration for sync across hosts.

### Create symlinks
After cloning this repository, create the symlinks
```
ln -s ~/work/config/_vimrc ~/.vimrc
ln -s ~/work/config/colors ~/.vim/colors
ln -s ~/work/config/_tmux.conf ~/.tmux.conf
ln -s ~/work/config/_zshrc ~/.zshrc
ln -s ~/work/config/_alacritty.yml ~/.config/alacritty/alacritty.yml
```
### Install vim-plug
```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
```shell
:PlugInst
```
### Config for git
To use vimdiff as difftool and mergetool
```shell
git config --global diff.tool vimdiff
git config --global difftool.prompt false
```
```shell
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
```
Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Install fzf
```shell
brew install fzf
brew install ripgrep

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```
Alternatively,
```shell
sudo yum install ripgrep
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
