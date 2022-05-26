## My vim & tmux configuration

### Install vim-plug
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
```
:PlugInst
```

### Config for git
To use vimdiff as difftool and mergetool
```
git config --global diff.tool vimdiff
git config --global difftool.prompt false
```
```
git config merge.tool vimdiff
git config merge.conflictstyle diff3
git config mergetool.prompt false
```
