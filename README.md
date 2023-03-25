# dotfiles

Hosts my zsh, vim, tmux & kitty configuration for sync across hosts.

1. Install [Homebrew](https://brew.sh).
2. Install wget with `brew install wget`.
3. Install tmux with `brew install tmux`.
4. Install [Kitty](https://sw.kovidgoyal.net/kitty/binary/)
5. Install fzf with `brew install fzf`.
6. Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md).
7. Install neovim with `brew install neovim`.
8. Install [lvim](https://www.lunarvim.org/docs/installation).
9. Install [tpm](https://github.com/tmux-plugins/tpm).
10. Install [nerd fonts](https://github.com/ryanoasis/nerd-fonts).
11. Install [tmux-256color](https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95) for macOS (for italic fonts).
12. Install exa with `brew install exa`.
13. Install GitHub CLI with `brew install gh`.

## Create symlinks

After cloning this repository, create the symlinks

```bash
ln -s ~/Code/dotfiles/.vimrc ~/.vimrc
ln -s ~/Code/dotfiles/config.lua ~/.config/lvim/config.lua
ln -s ~/Code/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/Code/dotfiles/colors ~/.vim/colors
ln -s ~/Code/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/Code/dotfiles/.zshrc ~/.zshrc
ln -s ~/Code/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
...
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
