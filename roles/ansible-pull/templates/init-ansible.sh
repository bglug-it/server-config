#!/bin/bash

# Fixing base variables.
basedir=/var/lib/{{ ansible_local.domain.domainfull }}
url=git://{{ ansible_local.domain.serverfqdn }}/client-pull-installation.git
branch={{ ansible_local.domain.client_gitbranch }}

# Creo directory dipendenti
echo "$(date --rfc-3339=seconds) Installing bin directory."
/usr/bin/install -d -o root -g users ${basedir}/bin

# Workaround issue #23 - ansible-pull won't pull out of remote the first time.
if [[ ! -f ${basedir}/config/local.yml ]]; then
  /usr/bin/git clone -b ${branch} ${url} ${basedir}/config
fi

# Installo ansible-pull.sh
echo "$(date --rfc-3339=seconds) Creating ansible-pull.sh."
/usr/bin/wget -q http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/ansible-pull.sh -O ${basedir}/bin/ansible-pull.sh
chmod a+x ${basedir}/bin/ansible-pull.sh

# Fixing permissions on the main directory
/bin/chown -R root:users ${basedir}

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
