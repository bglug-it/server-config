#!/bin/bash

url=https://github.com/syntaxerrormmm/pulltest.git
repo=/var/lib/{{ domainfull }}/config
logfile=/var/lib/ansible-pull.log

export https_proxy=https://{{ serverip }}:3128
ansible-pull -d "${repo}" -U "${url}"
unset https_proxy
