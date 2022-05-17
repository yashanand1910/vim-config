## My vim & tmux configuration

#### Config for git
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
