# dot-files

Personal dotfiles repo. Includes:
* vim
* bash
* i3



# Instructions

> git checkout https://github.com/jhazen/dot-files

> cd dot-files/

Run 'all' as a parameter to setup everything; otherwise specify which dot file to setup.

> ./install.sh (vim|bash|i3|all)


# Vim

Shortcuts:
* C-A - Autocomplete
* C-N - Toggle Nerdtree
* C-P - ctrlp (default workdir is ~/Workspace)
* C-T - Open new tab
* C-W - Previous tab
* C-E - Next tab
* C-U - undotree toggle
* C-B - Open bash tab
* C-Y - Open python tab
* C-D - Open sqlite3 tab
* C-F - Fold
* C-L - Lint file. Supported filetypes: spec, ruby, javascript and python.
* C-G - Tagbar toggle
* vv - Open vertical split
* ss - Open split
* bn - Next buffer
* bp - Previous buffer
* bB - Bash vsplit
* bP - Python vsplit
* bD - sqlite3 vsplit
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
* ,a - Page up
* ,z - Page down
* \r - Compile/run. Works with bash, python3, go, c/c++, java, asm
* \d - Jedi definitions
* \g - Jedi assignments
* \n - Jedi usages
* \k - Jedi pydoc
* \t - Golang autocompletion
* \b - Set python breakpoint
* \q - Open PDB
* \jn - Java generate new class
* \jN - Java generate new class in file
* \jc - Java generate constructor
* \jts - Java generate ToString
* \jA - Java generate accessors
* \jI - Java add missing imports
* \jR - Java remove unused imports
* \gs - Git status
* \gd - Git diff
* \gb - Git blame
* \gc - Git commit
* \gp - Git pull
* \gP - Git push
* \cd - CD to current git dir
* \cm - Run CMake
* \m - Run make
* \ww - Open wiki. Use <Enter> on a word to create/link new wiki. <C-Space> to create checkbox.
* \wt - Wiki tab
* \<Space> - Clear search highlight

Other useful tips:
* :Dox - Generate doxygen
* :ServerRequest <salt role name> - Creates a server in vagrantlab environment, sets salt role, and boots
* :Hex - Toggle hex editor
* :ServerShellTab <vagrantlab box name> - Create a conqueterm shell in new tab with SSH to the vagrant box
* :ServerShellVSplit <vagrantlab box name> - Create a conqueterm shell in new vsplit with SSH to the vagrant box
* :ServerStart <vagrantlab box name> - Start VM in vagrantlab
* :ServerStop <vagrantlab box name> - Stop VM in vagrantlab
* \<Space\> mapped to @q; Record macro to 'q' register and execute with \<Space\> (Default is comment line with #)


# Bash

For local bash changes, use ~/.bashlocal file.

Git prompt once in a git directory.

Vagrant aliases:
* vs - vagrant status
* vu - vagrant up
* vp - vagrant provision
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

Other aliases:
* ll - ls -l
* la - ls -la
* lh - ls -lh
* ltr - ls -ltr
* psg - ps aux | grep


# i3

i3 dot files.

# Help

Any bugs/concerns/issues/etc please email jhazen532@gmail.com.
