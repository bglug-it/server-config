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
