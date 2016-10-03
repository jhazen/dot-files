#!/usr/bin/python2.7

import fabric.api as fab
import os

fab.env.key_filename = os.path.expanduser('~/.ssh/fabric')

def df():
    fab.run('df')

def whoami():
    fab.run('whoami')

def uptime():
    fab.run('uptime')

def get_kernel():
    fab.run('uname -r')

def specs():
    numproc = fab.run('cat /proc/cpuinfo | grep processor | wc -l')
    nummemraw = fab.run('cat /proc/meminfo  | head -n 1 | cut -d":" -f2')
    nummem = int(nummemraw.split(" ")[0]) / 1024000 + 1
    print "Num processors:", numproc
    print "Total RAM:", str(nummem) + "G"

def get_file(rfile):
    lfile = rfile.split("/")[-1]
    hname = fab.run("hostname")
    fab.get(remote_path=rfile, local_path="log/" + lfile + hname)

def enable_autologin():
    fab.run('mkdir -p .ssh; chmod 700 .ssh')
    fab.put(".ssh/fabric.pub", ".ssh/authorized_keys")
    fab.run('chmod 600 .ssh/authorized_keys')

def top():
    fab.run('top -b -n 1 | head -n 12')

def free():
    fab.run('free -m')

def vgdisplay():
    fab.sudo('vgdisplay')
