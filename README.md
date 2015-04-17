# Repository di Ansible per configurazione del server di dominio con ClearOS #

Qui sono presenti i files di configurazione per il server ClearOS.
Per configurarlo:

    $ vim hosts
    $ ansible-playbook init.yml -u root --ask-pass \
	-e "admin_sshkey=/path/to/id_rsa.pub"
    $ ansible-playbook setup.yml 

# Gestione con vagrant #

Nel repo è stata caricata una macchina virtuale già pronta con Virtualbox per
l'uso con [`vagrant`](https://www.vagrantup.com/).

È pertanto possibile creare una macchina virtuale automatica eseguendo i
seguenti comandi:

    $ vagrant box add clearos6 ./clearos6-1.0.0.box
    $ vagrant init clearos6
