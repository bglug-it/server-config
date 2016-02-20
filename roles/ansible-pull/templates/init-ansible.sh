#!/bin/bash

# Creo directory dipendenti
echo "$(date --rfc-3339=seconds) Installing bin directory."
/usr/bin/install -d -o root -g users /var/lib/{{ ansible_local.domain.domainfull }}/bin
/bin/chown -R root:users /var/lib/{{ ansible_local.domain.domainfull }}

# Installo ansible-pull.sh
echo "$(date --rfc-3339=seconds) Creating ansible-pull.sh."
/usr/bin/wget -q http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/ansible-pull.sh -O /var/lib/{{ ansible_local.domain.domainfull }}/bin/ansible-pull.sh
chmod a+x /var/lib/{{ ansible_local.domain.domainfull }}/bin/ansible-pull.sh

# Installo il cronjob per ansible-pull
echo "$(date --rfc-3339=seconds) Creating crontab"
/usr/bin/wget -q http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/crontab -O /etc/cron.d/ansible-pull
/bin/chown root:root /etc/cron.d/ansible-pull
/bin/chmod 0644 /etc/cron.d/ansible-pull

# Installo il logrotate per ansible
echo "$(date --rfc-3339=seconds) Creating logrotate"
/usr/bin/wget -q http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/logrotate -O /etc/logrotate.d/ansible-pull
/bin/chown root:root /etc/logrotate.d/ansible-pull
/bin/chmod 0644 /etc/logrotate.d/ansible-pull
