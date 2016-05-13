#!/usr/bin/python2.7

import fabric.api as fab
import os

fab.env.key_filename = os.path.expanduser('~/.ssh/my')

def df():
    fab.run('df')

def whoami():
    fab.run('whoami')

def get_file(rfile):
    lfile = rfile.split("/")[-1]
    hname = fab.run("hostname")
    fab.get(remote_path=rfile, local_path="log/" + lfile + hname)
