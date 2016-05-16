#!/bin/bash

ssh $USER@$1 'mkdir -p .ssh'

cat ~/.ssh/fabric.pub | ssh $USER@$1 'cat >> .ssh/authorized_keys'
