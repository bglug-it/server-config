# Repository di Ansible per configurazione del server di dominio con ClearOS #

Qui sono presenti i files di configurazione per il server ClearOS.
Per configurarlo:

    $ vim hosts
    $ ansible-playbook init.yml -u root --ask-pass \
	-e "admin_sshkey=/path/to/id_rsa.pub"
    $ ansible-playbook setup.yml 
