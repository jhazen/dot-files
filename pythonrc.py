import sys
import os

#Tab completion
try:
    import readline
except ImportError:
    print "Module readline not available."
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")

#PS1 variable
sys.ps1 = "$ "
sys.ps2 = "> "

#Global variables
oldcwd = str(os.getcwd()).strip("'")

#Functions for using python as main shell
##Movement
def cd(new_cwd):
    oldcwd = str(os.getcwd()).strip("'")
    os.chdir(new_cwd)
def pwd():
    mypwd = str(os.getcwd()).strip("'")
    return mypwd
##Reading files
def cat(fname):
    with open(fname) as f:
        for i in f.read().split('\n'):
           print i
##Searching text
def grep(fname, grepval):
    with open(fname) as f:
        for line in f:
            if grepval in line:
                return line
