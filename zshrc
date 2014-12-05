alias vs='vagrant status'
alias vu='vagrant up'
alias vd='vagrant destroy'
alias vss='vagrant ssh'
alias vh='vagrant halt'
alias mvdeploy='mvn clean package wildfly:deploy'
alias mvundeploy='mvn wildfly:undeploy'
alias mcp='mvn clean package'
alias vi='vim'
alias gs='git status'
alias gb='git branch'
alias gd='git diff'
alias gc='git clone'
alias gch='git checkout'
alias gr='git remote -v'
alias gm='git merge'
alias gl='git log'
alias gc='git commit'
alias gp='git pull'
alias gP='git push'
alias ga='git add'
alias jbc='$JBOSS_HOME/bin/jboss-cli.sh -c'
alias jbs='nohup $JBOSS_HOME/bin/standalone.sh -c standalone-full.xml > /dev/null 2>&1 &'
alias jbk='jbc --command=":shutdown()"'
alias jbps='ps aux | grep wildfly | grep -v grep > /dev/null 2>&1 && echo "Running" || echo "Not Running"'
alias jbt='tail -f $JBOSS_HOME/standalone/log/server.log'
alias jbl='less $JBOSS_HOME/standalone/log/server.log'
alias jbls='jbc --command="deployment-info"'
alias ll='ls -l'

setopt prompt_subst
autoload colors zsh/terminfo
colors

bindkey -v
export KEYTIMEOUT=1
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
function zle-line-init zle-keymap-select {
  VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(__git_prompt) $EPS1"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

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

export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space
