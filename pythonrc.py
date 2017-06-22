import sys
import os
import re
import subprocess
from datetime import datetime
import atexit
from sh import ls, pwd, cd, git, wc, grep, sed, awk, tar, zip, unzip, cat, sort, mv, chown, chmod
import sqlite3
from scapy.all import *
import socket
import time
import threading
import queue
import paramiko
import xml.etree.ElementTree as ET
import json
import boto3
import requests
import urllib3
import yaml
from netaddr import *
import base64
from ctypes import *

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
    print("Module readline not available.")
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

#Local Dynamodb instance
from boto3.dynamodb.conditions import Attr
db = boto3.resource('dynamodb', endpoint_url='http://localhost:8000',
                  region_name='us-west-1', aws_access_key_id='any',
                  aws_secret_access_key='any')
