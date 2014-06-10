alias vs='vagrant status'
alias vu='vagrant up'
alias vd='vagrant destroy'
alias vss='vagrant ssh'
alias jboss-cli='jboss-cli.sh -c'
alias mvdeploy='mvn clean package wildfly:deploy'
alias mvundeploy='mvn wildfly:undeploy'
alias vi='vim'
alias gs='git status'
alias gb='git branch'
alias gc='git clone'
alias gch='git checkout'
alias gr='git remote'
alias gm='git merge'
alias gl='git log'
alias gc='git commit'
alias gp='git pull'
alias gP='git push'
alias ga='git add'
alias ll='ls -l'

setopt prompt_subst
autoload colors zsh/terminfo
colors

function __git_prompt {
  local DIRTY="%{$fg[yellow]%}"
  local CLEAN="%{$fg[green]%}"
  local UNMERGED="%{$fg[red]%}"
  local RESET="%{$terminfo[sgr0]%}"
  git rev-parse --git-dir >& /dev/null
  if [[ $? == 0 ]]
  then
    echo -n "["
    if [[ `git ls-files -u >& /dev/null` == '' ]]
    then
      git diff --quiet >& /dev/null
      if [[ $? == 1 ]]
      then
        echo -n $DIRTY
      else
        git diff --cached --quiet >& /dev/null
        if [[ $? == 1 ]]
        then
          echo -n $DIRTY
        else
          echo -n $CLEAN
        fi
      fi
    else
      echo -n $UNMERGED
    fi
    echo -n `git branch | grep '* ' | sed 's/..//'`
    echo -n $RESET
    echo -n "]"
  fi
}

export RPS1='$(__git_prompt)'
export PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%# "
