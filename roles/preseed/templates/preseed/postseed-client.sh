#!/bin/bash

# Cambio username con quello fornito da servizio
TARGETHOSTNAME=$(wget -qO- http://{{ ansible_local.domain.serverfqdn }}:3000/whatsmyhostname)
echo $TARGETHOSTNAME > /etc/hostname
sed -i'' -e "s/kickseed/$TARGETHOSTNAME/g" /etc/hosts

# Installo i file necessari per ansible.
curl -sSL http://{{ ansible_local.domain.serverfqdn }}/ks/ansible-pull/init-ansible.sh | /bin/bash
