#!/bin/bash

# Script provvisorio.
# Potremmo decidere di far eseguire uno script generato da servizio
# domainhelper contenente anche l'eventuale branch da usare.

url=git://{{ serverfqdn }}/client-pull-installation.git
repo=/var/lib/{{ domainfull }}/config
logfile=/var/lib/ansible-pull.log
branch=master
playbook=local.yml

ansible-pull -d "${repo}" -U "${url}" -C "${branch}" "${playbook}"
