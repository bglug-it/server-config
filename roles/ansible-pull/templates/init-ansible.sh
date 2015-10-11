#!/bin/bash

# Creo directory dipendenti
/usr/bin/install -d -o root -g users /var/lib/{{ ansible_local.domain.domainfull }}/config
/bin/chown -R root:users /var/lib/{{ ansible_local.domain.domainfull }}

# Installo il cronjob per ansible-pull
/usr/bin/wget -q http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/crontab -O /etc/cron.d/ansible-pull
/bin/chown root:root /etc/cron.d/ansible-pull
/bin/chmod 0644 /etc/cron.d/ansible-pull

# Installo il logrotate per ansible
/usr/bin/wget -q http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/logrotate -O /etc/logrotate.d/ansible-pull
/bin/chown root:root /etc/logrotate.d/ansible-pull
/bin/chmod 0644 /etc/logrotate.d/ansible-pull
