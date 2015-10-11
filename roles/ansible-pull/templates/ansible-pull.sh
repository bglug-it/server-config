#!/bin/bash

# Aggiorna crontab e logrotate forzosamente.
/usr/bin/curl -sSL http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/init-ansible.sh | /bin/bash

# Script provvisorio.
# Potremmo decidere di far eseguire uno script generato da servizio
# domainhelper contenente anche l'eventuale branch da usare.

url=git://{{ ansible_local.domain.serverfqdn }}/client-pull-installation.git
repo=/var/lib/{{ ansible_local.domain.domainfull }}/config
logfile=/var/lib/ansible-pull.log
branch=master
playbook=local.yml

vaultpassfile=$(/usr/bin/curl -sSL http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/getvaultpass.py | /usr/bin/python)

/usr/bin/ansible-pull --accept-host-key -d "${repo}" -U "${url}" -C "${branch}" "${playbook}" --vault-password-file "${vaultpassfile}" $@
rm -f "${vaultpassfile}"
