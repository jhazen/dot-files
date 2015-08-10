# dot-files

Personal dotfiles repo. Includes:
* vim
* zsh
* openbox
* conky
* tint2
* wbar
* gtk2


# Instructions

> git checkout https://github.com/jhazen/dot-files

> cd dot-files/

Run 'all' as a parameter to setup everything; otherwise specify which dot file to setup.

> ./install.sh (vim|zsh|openbox|conky|wbar|gtk2|tint2|all)


# Vim

Shortcuts:
* C-N - Toggle Nerdtree
* C-P - ctrlp
* C-T - Open new tab
* C-W - Previous tab
* C-E - Next tab
* C-U - Gundo toggle
* C-B - Open bash tab
* F5 - If in a puppet file, lint the file. If ruby, rspec the file. If spec, rpmlint the file.
* vv - Open vertical split
* ss - Open split
* tt - Toggle Tagbar
* nn - Next buffer
* pp - Previous buffer
* bb - Bash vsplit
* ,q - Resize vsplit to the left
* ,r - Resize vsplit to the right
* ,e - Resize split up
* ,w - Resize split down
* ,h - Move left between vsplit
* ,l - Move right between vsplit
* ,k - Move up between split
* ,j - Move down between split
* ,H - Move vsplit to the left
* ,L - Move vsplit to the right
* ,K - Move split up
* ,J - Move split down

Other useful tips:
* :Gstatus - Git status
* :Gcommit - Git commit
* :Git - Git


# Zsh

Vim mode zsh. Esc puts terminal in command mode.

For local zsh changes, use ~/.zshlocal file.

Right handed git prompt once in a git directory.

Vagrant aliases:
* vs - vagrant status
* vu - vagrant up
* vd - vagrant destroy
* vss - vagrant ssh
* vh - vagrant halt

Maven aliases:
* mvdeploy - mvn clean package wildfly:deploy
* mvundeploy - mvn wildfly:undeploy
* mcp - mvn clean package

Git aliases:
* gs - git status
* gb - git branch
* gd - git diff --color
* gdt - git difftool
* gc - git clone
* gch - git checkout
* gr - git remote
* gm - git merge
* gmt - git mergetool
* gl - git log --oneline --decorate --color --graph
* gc - git commit
* gp - git pull
* gP - git push
* ga - git add
* gf - git fetch
* grm - git rm
* gconf - git config
* ginit - git init
* greset - git reset
* gst - git stash

JBoss control script (Make sure to set $JBOSS_HOME variable):
jbctl (command) <arguments>
* COMMAND         PURPOSE                 ARGUMENTS               EXAMPLE
* version         Check version           n/a                     jbctl version
* hist            CLI history             n/a                     jbctl hist
* cmd             Open CLI                n/a                     jbctl cmd
* start           Start JBoss             n/a                     jbctl start
* stop            Stop JBoss              n/a                     jbctl stop
* restart         Restart JBoss           n/a                     jbctl restart
* home            Display JBoss home      n/a                     jbctl home
* lssnap          Display snaps           n/a                     jbctl lssnap
* tksnap          Take snapshot           n/a                     jbctl tksnap
* rmsnap          Delete snap             Snapshot name           jbctl rmsnap 20150810-221949391domain.xml
* lsdeploy        Display deployments     Server group name       jbctl lsdeploy sg01
* less            Open log in less        n/a                     jbctl less
* tail            Tail -f log             n/a                     jbctl tail
* status          Check running state     n/a                     jbctl status
* lsservers       List servers in domain  n/a                     jbctl lsservers
* phist           Show patch history      Server name             jbctl phist work-s01
* sgrestart       Restart a server group  Server group name       jbctl sgrestart sg01


Other aliases:
* ll - ls -l
* la - ls -la
* lh - ls -lh
* ltr - ls -ltr
* psg - ps aux | grep


# Help

Any bugs/concerns/issues/etc please email jhazen532@gmail.com.
