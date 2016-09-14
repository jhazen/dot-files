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
    echo -en $P
  fi
}
PS1='\[\e[1;31m\]\u\[\e[0m\]@\[\e[1;34m\]\h\[\e[0m\] [\[\e[0;37m\]\W\[\e[0m\]]$(__git_prompt) # '

source ~/.aliases

export PYTHONSTARTUP=~/.pythonrc.py
export PYTHONPATH=$PYTHONPATH:~/Workspace/lib

if [ -f ~/.bashlocal ]; then
  source ~/.bashlocal
fi