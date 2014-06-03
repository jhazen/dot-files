#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

for config_file ($HOME/.yadr/zsh/*.zsh) source $config_file
  alias vs='vagrant status'
  alias vu='vagrant up'
  alias vd='vagrant destroy'
  alias vss='vagrant ssh'
  alias jboss-cli='jboss-cli.sh -c'
alias vi='vim'
export EMAIL="jhazen532@gmail.com"
export PATH=$PATH:/usr/share/wildfly/bin
archey3
