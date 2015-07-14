#!/bin/bash

echo "Please review ansible hosts settings."
sleep 2
vim hosts

echo "Please review settings for domain/server settings."
sleep 2
vim domain.yml

# Configure the server machine using Ansible tasks.
ansible-playbook init.yml --ask-pass
ansible-playbook setup.yml
