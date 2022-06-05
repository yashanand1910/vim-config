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
Install bash-git-prompt
```shell
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
```
Add to the ~/.bashrc
```shell
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi
```

### Install fzf
```shell
brew install fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```
