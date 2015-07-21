# Ansible configuration playbooks for SMB domain controller with [NethServer](http://www.nethserver.org/) #

![BgLUG logo](https://avatars1.githubusercontent.com/u/12886037?v=3&s=200)
## Progetto Scuola @ [BgLUG](http://bglug.it) - Scenary 1 ##

Here there are [Ansible](http://www.ansible.com/) configuration for a SMB
domain controller with the use of a NethServer server.

It presume a machine with NethServer has been already been configured as base
(please check out the [wiki](https://github.com/bglug-it/server-config/wiki)
for more information, when available).

### Quick start ###

You may proceed in using the files in this repo proceeding as follows:

    $ vim hosts
    $ vim domain.yml
    $ ansible-playbook init.yml --ask-pass \
         -e "admin_sshkey=/path/to/id_rsa.pub"
    $ ansible-playbook setup.yml 

Or, more simply:

    $ bash run.sh

### Use [`vagrant`](http://www.vagrantup.com) for testing purposes ###

You may use the included `Vagrantfile` to do any tests before deploying the
machine.

You just need `vagrant` installed on your machine, then you may run these
commands:

    $ cd /path/to/server-config
    $ vagrant up

Update 14/06/2015: some basic configuration to the Vagrant box are now
provisioned via Ansible, thus requiring that you have it installed on the host
machine.

Update 25/06/2015: the Vagrant box now uses a *host-only* interface instead of
a *bridged* one.

### To Do List ###

* Splitting and finalize pxe roles (pxe + kickstart)
* Implement backup
* Detail physical installation procedure for the server machine within the
  Wiki.
