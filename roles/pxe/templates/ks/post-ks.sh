#!/bin/bash

# Cambio username con quello fornito da servizio
TARGETHOSTNAME=$(wget -qO- http://{{ serverfqdn }}:3000/whatsmyhostname)
echo $TARGETHOSTNAME > /etc/hostname
sed -i "s/kickseed/$TARGETHOSTNAME/g" /etc/hosts

# Installo l'ultimo ansible per ansible-pull
export https_proxy=https://{{ serverip }}:3128
add-apt-repository -y ppa:ansible/ansible
apt-get update && apt-get install -y ansible
unset https_proxy

# Creo directory dipendenti
install -d -o root -g root /var/lib/{{ domainfull }}/config
install -d -o root -g root /var/lib/{{ domainfull }}/bin

# Installo lo script per la decrittazione della password del vault
wget -q http://{{ serverfqdn }}/ks/getvaultpass.py -O /tmp/getvaultpass.py
python /tmp/getvaultpass.py && rm -f /tmp/getvaultpass.py

# Installo lo script per l'avvio di ansible-pull da root
wget -q http://{{ serverfqdn }}/ks/ansible-pull.sh -O /tmp/ansible-pull.sh
install -m744 -o root -g root /tmp/ansible-pull.sh /var/lib/{{ domainfull }}/bin/ansible-pull.sh
rm -f /tmp/ansible-pull.sh

# Installo il cronjob
wget -q http://{{ serverfqdn }}/ks/ansible-pull-crontab -O /tmp/ansible-pull-crontab
install -m644 -o root -g root /tmp/ansible-pull-crontab /etc/cron.d/ansible-pull
rm -f /tmp/ansible-pull-crontab
# Installo il logrotate
wget -q http://{{ serverfqdn }}/ks/ansible-pull-logrotate -O /tmp/ansible-pull-logrotate
install -m644 -o root -g root /tmp/ansible-pull-logrotate /etc/logrotate.d/ansible-pull
rm -f /tmp/ansible-pull-logrotate
