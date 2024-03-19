# dotfiles

Hosts my zsh, vim, tmux & kitty configuration for sync across hosts. The vim config is a super-light subset of neovim config at least in terms of key bindings.

1. Install [Homebrew](https://brew.sh).
2. Install wget with `brew install wget`.
3. Install tmux with `brew install tmux`.
4. Install [Kitty](https://sw.kovidgoyal.net/kitty/binary/)
5. Install [fzf](https://github.com/junegunn/fzf) with `brew install fzf`.
6. Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md).
7. Install neovim with `brew install neovim`.
9. Install [tpm](https://github.com/tmux-plugins/tpm).
10. Install [nerd fonts](https://github.com/ryanoasis/nerd-fonts).
11. Install [tmux-256color](https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95) for macOS (for italic fonts).
12. Install exa with `brew install exa`.
13. Install GitHub CLI with `brew install gh`.
14. Install [ripgrep](https://github.com/BurntSushi/ripgrep) if using vim and not lvim.
15. Install [homerow](https://www.homerow.app)
16. Install [Karabiner-Elements](https://karabiner-elements.pqrs.org/index.html)

## Create symlinks

After cloning this repository, create the symlinks

```bash
ln -s ~/Code/dotfiles/.vimrc ~/.vimrc
ln -s ~/Code/dotfiles/nvim ~/.config/nvim/
ln -s ~/Code/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/Code/dotfiles/colors ~/.vim/colors
ln -s ~/Code/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/Code/dotfiles/.zshrc ~/.zshrc
ln -s ~/Code/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s ~/Code/dotfiles/karabiner/karabiner.json ~/.config/karabiner/
ln -s ~/Code/dotfiles/karabiner/assets ~/.config/karabiner/
...
```

## Install oh-my-zsh

```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
For a better vi mode
```bash
git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH_CUSTOM/plugins/zsh-vi-mode
```

## Install vim-plug (if using vim)

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```   
```bash
:PlugInst
```
