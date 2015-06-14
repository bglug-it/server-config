# Progetto Scuola @ [BgLUG](http://bglug.it) - Scenario implementativo 1 #
## PDC con SAMBA e Nethserver ##


### Utilizzo delle configurazioni con [`ansible`](http://www.ansible.com) ###

Qui sono presenti i files di configurazione per il server [NethServer](http://www.nethserver.org/).
Per configurarlo:

    $ vim hosts
    $ ansible-playbook init.yml --ask-pass \
         -e "admin_sshkey=/path/to/id_rsa.pub"
    $ ansible-playbook setup.yml 

### Gestione con [`vagrant`](http://www.vagrantup.com) ###

Per utilizzare `vagrant` e il `Vagrantfile` nel
repo, è necessario avere `vagrant` installato sulla propria macchina e
lanciare i seguenti comandi:

    $ cd /path/to/ps-srvmgt
    $ vagrant up

Aggiornamento 14/06/2015: vengono provisionate via Vagrant e Ansible alcune
configurazioni dal Vagrantfile.

### To Do List ###

* Implementare PXE + Kickstart (manca test)
* Implementare configurazioni per repo Ubuntu (test)
* Implementare configurazioni generiche dominio server
* Implementare aggiornamento automatico del sistema via `ansible`
* Implementare backup
