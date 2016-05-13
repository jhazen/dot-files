#!/usr/bin/python2.7

import fabric.api as fab
import os

fab.env.key_filename = os.path.expanduser('~/.ssh/my')

def df():
    fab.run('df')

def whoami():
    fab.run('whoami')

def uptime():
    fab.run('uptime')

def specs():
    numprocraw = fab.run('cat /proc/cpuinfo | grep processor | tail -n 1 | cut -d":" -f2')
    numproc = int(numprocraw) + 1
    nummemraw = fab.run('cat /proc/meminfo  | head -n 1 | cut -d":" -f2')
    nummem = int(nummemraw.split(" ")[0]) / 1024000 + 1
    print "Num processors:", numproc
    print "Total RAM:", str(nummem) + "G"

def get_file(rfile):
    lfile = rfile.split("/")[-1]
    hname = fab.run("hostname")
    fab.get(remote_path=rfile, local_path="log/" + lfile + hname)
