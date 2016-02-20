#!/bin/bash

# waiting for dns stack to be ready
while true; do
  [[ "$(dig +short {{ ansible_local.domain.serverfqdn }})" == "{{ ansible_local.domain.serverip }}" ]] && break;
done

# Aggiorna crontab e logrotate forzosamente.
echo "$(date --rfc-3339=seconds) Loading and running init-ansible.sh"
/usr/bin/curl -sSL4 http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/init-ansible.sh | /bin/bash

# Script provvisorio.
# Potremmo decidere di far eseguire uno script generato da servizio
# domainhelper contenente anche l'eventuale branch da usare.

url=git://{{ ansible_local.domain.serverfqdn }}/client-pull-installation.git
repo=/var/lib/{{ ansible_local.domain.domainfull }}/config
logfile=/var/lib/ansible-pull.log
branch={{ ansible_local.domain.client_gitbranch }}
playbook=local.yml

echo "$(date --rfc-3339=seconds) Getting vault password"
vaultpassfile=$(/usr/bin/curl -sSL4 http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/getvaultpass.py | /usr/bin/python)

echo "$(date --rfc-3339=seconds) Running ansible-pull"
/usr/bin/ansible-pull --accept-host-key -i localhost -d "${repo}" -U "${url}" -C "${branch}" "${playbook}" --vault-password-file "${vaultpassfile}" $@
rm -f "${vaultpassfile}"
