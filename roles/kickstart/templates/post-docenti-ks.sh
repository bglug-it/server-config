#!/bin/bash

# Cambio username con quello fornito da servizio
TARGETHOSTNAME=$(wget -qO- http://{{ ansible_local.domain.serverfqdn }}:3000/whatsmyhostname?role=docenti)
echo $TARGETHOSTNAME > /etc/hostname
sed -i "s/kickseed/$TARGETHOSTNAME/g" /etc/hosts

{% if ansible_product_name == 'VirtualBox' %}
# Installo l'ultimo ansible per ansible-pull
export https_proxy=https://{{ ansible_local.domain.serverip }}:3128
add-apt-repository -y ppa:ansible/ansible
apt-get update && apt-get install -y ansible
unset https_proxy
{% else %}
# Adding ansible manually from local
wget -qO- http://{{ ansible_local.domain.serverfqdn }}/ks/ppa-ansible.gpg | apt-key add -
wget -q http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-ansible-trusty.list -O /etc/apt/sources.list.d/ansible-ansible-trusty.list
apt-get update && apt-get install -y ansible
{% endif %}

# Creo directory dipendenti
install -d -o root -g root /var/lib/{{ ansible_local.domain.domainfull }}/config
install -d -o root -g root /var/lib/{{ ansible_local.domain.domainfull }}/bin

# Installo lo script per la decrittazione della password del vault
wget -q http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/getvaultpass.py -O /tmp/getvaultpass.py
install -m744 -o root -g root /tmp/getvaultpass.py /var/lib/{{ ansible_local.domain.domainfull}}/bin/getvaultpass.py
rm -f /tmp/getvaultpass.py

# Installo lo script per l'avvio di ansible-pull da root
wget -q http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/run.sh -O /tmp/ansible-pull.sh
install -m744 -o root -g root /tmp/ansible-pull.sh /var/lib/{{ ansible_local.domain.domainfull }}/bin/ansible-pull.sh
rm -f /tmp/ansible-pull.sh

# Installo il cronjob
wget -q http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/crontab -O /tmp/ansible-pull-crontab
install -m644 -o root -g root /tmp/ansible-pull-crontab /etc/cron.d/ansible-pull
rm -f /tmp/ansible-pull-crontab
# Installo il logrotate
wget -q http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/logrotate -O /tmp/ansible-pull-logrotate
install -m644 -o root -g root /tmp/ansible-pull-logrotate /etc/logrotate.d/ansible
rm -f /tmp/ansible-pull-logrotate
