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
import fabric.api as fab
import bs4 as bs
from sh import ls, pwd, cd, git, wc, grep, sed, awk, tar, zip, unzip, cat, sort, mv, chown, chmod
import sqlite3

#PS1 variable
sys.ps1 = "$ "
sys.ps2 = "> "

#Global variables
histPath = os.path.expanduser("~/.python_history2.7")
fab.env.key_filename = os.path.expanduser('~/.ssh/fabric')

#Functions for using python as main shell
##Save history
def save_history(histPath=histPath):
    import readline
    readline.write_history_file(histPath)
##Allow running fabric from python shell
def fabric(cmd, hosts, args=""):
    if len(args) > 0:
        fullcmd = cmd + ":" + args
    else:
        fullcmd = cmd
    if type(hosts) is list or type(hosts) is tuple:
        for host in hosts:
            os.system("fab " + fullcmd + " -H " + host)
    elif type(hosts) is str:
        os.system("fab " + fullcmd + " -H " + hosts)
    else:
        print "Error: hosts must be string, list or tuple."
##SSH
def ssh(hosts, *cmd):
    if cmd:
        fullcmd = ""
        for i in cmd:
            fullcmd += " | " + i
        fullcmd = fullcmd.lstrip(' | ')
    if type(hosts) is list or type(hosts) is tuple:
        for host in hosts:
            fab.env.host_string = host
            if cmd:
                fab.run(fullcmd)
            else:
                fab.open_shell()
    elif type(hosts) is str:
        fab.env.host_string = hosts
        if cmd:
            fab.run(fullcmd)
        else:
            fab.open_shell()
    else:
        print "Error: hosts must be string, list or tuple."
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