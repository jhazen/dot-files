alias vs='vagrant status'
alias vu='vagrant up'
alias vd='vagrant destroy'
alias vss='vagrant ssh'
alias vh='vagrant halt'
alias mvdeploy='mvn clean package wildfly:deploy'
alias mvundeploy='mvn wildfly:undeploy'
alias mcp='mvn clean package'
alias vi='vim'
alias gf='git fetch'
alias grm='git rm'
alias gs='git status'
alias gb='git branch'
alias gd='git diff --color'
alias gdt='git difftool'
alias gc='git clone'
alias gconf='git config'
alias ginit='git init'
alias greset='git reset'
alias gst='git stash'
alias gch='git checkout'
alias gr='git remote -v'
alias gm='git merge'
alias gmt='git mergetool'
alias gl='git log --oneline --decorate --color --graph'
alias gc='git commit'
alias gp='git pull'
alias gP='git push'
alias ga='git add'
alias jbc='$JBOSS_HOME/bin/jboss-cli.sh -c'
alias jbs='nohup $JBOSS_HOME/bin/domain.sh > /dev/null 2>&1 &'
jbk() {
  jbc --command="shutdown --host=$*" || echo "\n\njbk <node name>\n"
}
jbrsg() {
  jbc --command="/server-group=`echo -e $1`:restart-servers()" || echo "\n\njbrsg <server group>\n"
}
jbphistory() {
  jbc --command="patch history --host=$*" || echo "\n\njbphistory <node name>"
}
alias jbservers='jbc --command="ls -l /host"'
alias jbps='ps aux | grep jboss | grep -v grep > /dev/null 2>&1 && echo "Running" || echo "Not Running"'
alias jbt='tail -f $JBOSS_HOME/domain/log/host-controller.log'
alias jbl='less $JBOSS_HOME/domain/log/host-controller.log'
jbls() {
  jbc --command="deployment-info --server-group=$*" || echo "\n\njbls <server group>\n"
}
alias jbv='jbc --version'
alias jbhistory='cat ~/.jboss-cli-history'
alias jbsnap='jbc --command=":take-snapshot"'
jbctl() {
  case $1 in
    version)
      jbc --version
      ;;
    start)
      nohup $JBOSS_HOME/bin/domain.sh > /dev/null 2>&1 &
      ;;
    stop)
      jbc --command="shutdown --host=$2" || echo "\n\njbctl stop <node name>\n"
      ;;
    restart)
      jbc --command="shutdown --host=$2"
      nohup $JBOSS_HOME/bin/domain.sh > /dev/null 2>&1 &
      ;;
    sgrestart)
      jbc --command="/server-group=`echo -e $2`:restart-servers()" || echo "\n\njbctl sgrestart <server group>\n"
      ;;
    phist)
      jbc --command="patch history --host=$2" || echo "\n\njbctl phist <node name>"
      ;;
    lsservers)
      jbc --command="ls -l /host"
      ;;
    status)
      ps aux | grep jboss | grep -v grep > /dev/null 2>&1 && echo "Running" || echo "Not Running"
      ;;
    tail)
      tail -f $JBOSS_HOME/domain/log/host-controller.log
      ;;
    less)
      less $JBOSS_HOME/domain/log/host-controller.log
      ;;
    lsdeploy)
      jbc --command="deployment-info --server-group=$2" || echo "\n\njbctl lsdeploy <server group>\n"
      ;;
    tksnap)
      jbc --command=":take-snapshot"
      ;;
    lssnap)
      jbc --command=":list-snapshots"
      ;;
    cmd)
      jbc
      ;;
    home)
      echo "JBOSS_HOME is set to: $JBOSS_HOME"
      ;;
    hist)
      cat ~/.jboss-cli-history
      ;;
    *)
      echo "jbctl {version|hist|cmd|start|stop|restart|home|lssnap|tksnap|lsdeploy|less|tail|status|lsservers|phist|sgrestart} <server group> <node name>"
      ;;
  esac
}
alias ll='ls -l'
alias la='ls -la'
alias lh='ls -lh'
alias ltr='ls -ltr'
alias psg='ps aux | grep'

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

if [ -f ~/.zshlocal ]; then
  source ~/.zshlocal
fi
