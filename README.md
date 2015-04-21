# Repository di Ansible per configurazione del server di dominio con NethServer #

Qui sono presenti i files di configurazione per il server [NethServer](http://www.nethserver.org/).
Per configurarlo:

    $ vim hosts
    $ ansible-playbook init.yml -u root --ask-pass \
         -e "admin_sshkey=/path/to/id_rsa.pub"
    $ ansible-playbook setup.yml 

# Gestione con vagrant #

Per utilizzare [`vagrant`](http://www.vagrantup.com) e il `Vagrantfile` nel
repo, è necessario avere `vagrant` installato sulla propria macchina e
lanciare i seguenti comandi:

    $ cd /path/to/ps-srvmgt
    $ vagrant up
