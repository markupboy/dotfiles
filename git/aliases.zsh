#git svn
alias dcommit='git svn dcommit'
alias svnrebase='git svn rebase'

#shorter aliases
alias g='git'
alias gh='hub'
alias gb='git branch'
alias gmv='git mv'
alias gr='git rebase'
alias gc='git commit'
alias gco='git checkout'
alias gca='git commit -a'
alias gp='git push'
alias gl='git pull'
alias glr='git pull --rebase'
alias gt='git-track-remote'
alias gm='git merge'
alias gs='git status -sb'
alias gd='git difftool'
alias ga='git add'
alias gaa='git-all'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gu="git undo"
alias gpu="git push -f origin HEAD^:master"

# add and remove new/deleted files from git index automatically
alias gitar="git ls-files -d -m -o -z --exclude-standard | xargs -0 git update-index --add --remove"

# git push
alias gpd="git push origin develop"
alias gpm="git push origin master"

# Remove git from a project
alias ungit="find . -name '.git' -exec rm -rf {} \;"
