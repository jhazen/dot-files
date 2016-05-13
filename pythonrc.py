import sys
import os
import re
import subprocess
from datetime import datetime
import urllib2
import requests
import paramiko
from getpass import getpass as pw
import atexit

#PS1 variable
sys.ps1 = "$ "
sys.ps2 = "> "

#Global variables
oldcwd = str(os.getcwd()).strip("'")
histPath = os.path.expanduser("~/.python_history2.7")

#Functions for using python as main shell
##Movement
def cd(new_cwd):
    oldcwd = str(os.getcwd()).strip("'")
    os.chdir(new_cwd)
def pwd():
    mypwd = str(os.getcwd()).strip("'")
    return mypwd
##Save history
def save_history(histPath=histPath):
    import readline
    readline.write_history_file(histPath)
##Allow running fabric from python shell
def fabric(cmd, hosts):
    os.system("fab " + cmd + " -H " + hosts)

#Tab completion
try:
    import readline
except ImportError:
    print "Module readline not available."
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")

#Read history at start
if os.path.exists(histPath):
    readline.read_history_file(histPath)
atexit.register(save_history)
