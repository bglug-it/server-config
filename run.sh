#!/bin/bash

echo "Please review ansible hosts settings."
sleep 2
$EDITOR ./hosts

echo "Please review settings for domain/server settings."
sleep 2
$EDITOR domain.yml

echo "Please review mirror settings from mirror.yml."
sleep 2
$EDITOR mirror.yml

# Configure the server machine using Ansible tasks.
ansible-playbook init.yml --ask-pass
ansible-playbook setup.yml
