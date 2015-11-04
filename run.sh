#!/bin/bash

echo "Please review ansible hosts settings."
sleep 2
$EDITOR ./hosts

echo "Please review settings for domain/server settings."
sleep 2
$EDITOR domain.yml

# Configure the server machine using Ansible tasks.
ansible-playbook init.yml --ask-pass -e admin_sshkey=$HOME/.ssh/id_rsa.pub
ansible-playbook setup.yml
