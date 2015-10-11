#!/bin/bash

# Cambio username con quello fornito da servizio
TARGETHOSTNAME=$(/usr/bin/wget -qO- http://{{ ansible_local.domain.serverfqdn }}:3000/whatsmyhostname?role=docenti)
echo $TARGETHOSTNAME > /etc/hostname
/bin/sed -i'' -e "s/kickseed/$TARGETHOSTNAME/g" /etc/hosts

# Installo i file necessari per ansible.
/usr/bin/curl -sSL4 http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/init-ansible.sh | /bin/bash
