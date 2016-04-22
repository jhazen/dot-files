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
* F5 - Lint file. Supported filetypes: spec, ruby, puppet and python.
* F6 - Execute current file and place output in horizontal split.
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
* <Space> mapped to @q; Record macro to 'q' register and execute with <Space>


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
* vr - vagrant rdp

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
* jbctl version - Check version
* jbctl hist - CLI history
* jbctl cmd - Open CLI
* jbctl start - Start JBoss
* jbctl stop - Stop JBoss
* jbctl restart - Restart JBoss
* jbctl home - Display JBoss home
* jbctl lssnap - Display snaps
* jbctl tksnap - Take snapshot
* jbctl rmsnap (snapshot name) - Delete snap
* jbctl lsdeploy (servergroup name) - Display deployments
* jbctl deploy (artifact, servergroup name) - Deploy artifact
* jbctl undeploy (artifact) - Undeploy artifact
* jbctl less - Open log in less
* jbctl tail - Tail -f log
* jbctl status - Check running state
* jbctl lsservers - List servers in domain
* jbctl phist (server name) - Show patch history
* jbctl sgrestart (servergroup name) - Restart a server group


Other aliases:
* ll - ls -l
* la - ls -la
* lh - ls -lh
* ltr - ls -ltr
* psg - ps aux | grep


# Help

Any bugs/concerns/issues/etc please email jhazen532@gmail.com.
