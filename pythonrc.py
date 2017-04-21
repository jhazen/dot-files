import sys
import os
import re
import subprocess
from datetime import datetime
import atexit
from sh import ls, pwd, cd, git, wc, grep, sed, awk, tar, zip, unzip, cat, sort, mv, chown, chmod
import sqlite3

#PS1 variable
sys.ps1 = "$ "
sys.ps2 = "> "

#Global variables
histPath = os.path.expanduser("~/.python_history")

#Functions for using python as main shell
##Save history
def save_history(histPath=histPath):
    import readline
    readline.write_history_file(histPath)

#Tab completion
try:
    import readline
except ImportError:
    print "Module readline not available."
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")
if 'libedit' in readline.__doc__:
        readline.parse_and_bind("bind ^I rl_complete")
else:
        readline.parse_and_bind("tab: complete")

#Read history at start
if os.path.exists(histPath):
    readline.read_history_file(histPath)
atexit.register(save_history)
