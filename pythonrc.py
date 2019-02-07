import sys
import os
import re
import subprocess
from datetime import datetime
import atexit
from kamene import *
import socket
import time
import threading
import queue
import collections
import paramiko
import xml.etree.ElementTree as ET
import json
import csv
import boto3
import requests
import urllib3
import yaml
from netaddr import *
import base64
from ctypes import *
import numpy as np
import heapq
import bz2
import gzip
import sqlite3
from unqlite import UnQLite

#PS1 variable
sys.ps1 = "$ "
sys.ps2 = "> "

#Global variables
histPath = os.path.expanduser("~/.python_history")
home = os.environ.get('HOME')

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
ddb = boto3.resource('dynamodb', endpoint_url='http://localhost:8000',
                  region_name='us-west-1', aws_access_key_id='any',
                  aws_secret_access_key='any')

#SQLite db
sdb = sqlite3.connect(home + "/main.db")
sdbc = sdb.cursor()

#UnQlite db
udb = UnQLite(home + "/umain.db")

#Mylock
def mylock():
    subprocess.Popen('mylock')

#Pass bash commands as list
def sh(cmd):
    subprocess.Popen(cmd)
