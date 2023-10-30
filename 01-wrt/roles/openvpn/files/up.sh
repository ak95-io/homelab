#!/bin/bash

export PS4='+ (B${SHLVL}/S${BASH_SUBSHELL}) ${BASH_SOURCE}:${LINENO}${FUNCNAME[0]:+:${FUNCNAME[0]}()}: '
exec &>> output.txt
set -x

/usr/sbin/nextdns restart
