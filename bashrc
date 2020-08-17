function __git_prompt {
  DIRTY='\e[1;33m'
  CLEAN='\e[1;36m'
  UNMERGED='\e[1;31m'
  RESET='\e[0m'
  git rev-parse --git-dir >& /dev/null
  if [[ $? == 0 ]]
  then
    P="["
    if [[ `git ls-files -u >& /dev/null` == '' ]]
    then
      git diff --quiet >& /dev/null
      if [[ $? == 1 ]]
      then
        P="$P$DIRTY"
      else
        git diff --cached --quiet >& /dev/null
        if [[ $? == 1 ]]
        then
          P="$P$DIRTY"
        else
          P="$P$CLEAN"
        fi
      fi
    else
      P="$P$UNMERGED"
    fi
    P="$P`git branch | grep '* ' | sed 's/..//'`"
    P="$P$RESET"
    P="$P]"
    echo -en " $P"
  fi
}

PS1='\[\033[01;34m\][\h \w]\[\e[0m$(__git_prompt)\]\[\033[00m\]\n% '

source ~/.aliases

HISTSIZE=100000
shopt -s histappend

export GOBIN=~/Workspace/go/bin
export GOPATH=~/Workspace/go
export PATH=~/bin:~/.bin:~/Workspace/go/bin:$PATH

if [ -f ~/.bashlocal ]; then
  source ~/.bashlocal
fi

if [ -f ~/.todo ]; then
    cat ~/.todo
fi
unset PYTHONPATH
