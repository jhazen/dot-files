import sys
import os
import re
import subprocess
from datetime import datetime
import urllib2
import requests
import paramiko
from getpass import getpass as pw

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
