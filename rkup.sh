#!/bin/bash
LOG="/var/log/rkup-`date +%s`"
rkhunter --propupd --pkgmgr rpm 2>&1 >> $LOG
rkhunter --update 2>&1 >> $LOG
rkhunter --check --cronjob 2>&1 >> $LOG
