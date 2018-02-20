#!/bin/bash

cd $VAGRANTLAB

VAGRANT_LOG=debug vagrant up $1 &> /tmp/vagrant.log.$1
