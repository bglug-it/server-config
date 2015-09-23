#!/bin/bash

# Script provvisorio.
# Potremmo decidere di far eseguire uno script generato da servizio
# domainhelper contenente anche l'eventuale branch da usare.

url=git://{{ ansible_local.domain.serverfqdn }}/client-pull-installation.git
repo=/var/lib/{{ ansible_local.domain.domainfull }}/config
logfile=/var/lib/ansible-pull.log
branch=master
playbook=local.yml

vaultpassfile=$(/var/lib/{{ ansible_local.domain.domainfull }}/bin/getvaultpass.py)

ansible-pull --only-if-changed --accept-host-key -d "${repo}" -U "${url}" -C "${branch}" "${playbook}" --vault-password-file "${vaultpassfile}" $@
rm -f "${vaultpassfile}"
