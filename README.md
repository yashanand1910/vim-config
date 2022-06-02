## My vim & tmux configuration

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
git config merge.tool vimdiff
git config merge.conflictstyle diff3
git config mergetool.prompt false
```
### Install fzf
```shell
brew install fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```
