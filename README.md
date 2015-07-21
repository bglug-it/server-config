# Ansible playbooks for a SAMBA domain controller with NethServer #

## Progetto Scuola [<img src="https://avatars1.githubusercontent.com/u/12886037?v=3&s=200" width="25" height="25" alt="BgLUG Logo" /> BgLUG][bglug] - Scenary 1 ##

Starting from a [NethServer][] configured machine (please check out the
[wiki][] for the installation process from [CentOS][] and other requirements),
these playbooks provision a [SAMBA][] 3.0 domain controller which can be used
with a network of Ubuntu clients.

Using the default settings, it will also provide an environment to boot from
network, install and configure the clients, using a local copy of Ubuntu's
repositories.

### Quick start ###

You may use these playbooks as follows:

    $ vim hosts
    $ vim domain.yml
    $ ansible-playbook init.yml --ask-pass -e "admin_sshkey=/path/to/id_rsa.pub"
    $ ansible-playbook setup.yml 

Or, more simply:

    $ bash run.sh

### Use [Vagrant][] for testing purposes ###

You may use the included `Vagrantfile` to do any tests before deploying the
machine. `vagrant` and `ansible` must be installed on the host machine, then
you may run the following commands:

    $ cd /path/to/server-config
    $ vagrant up

Update 14/06/2015: some basic configurations to the Vagrant box are now
provisioned via Ansible, thus making it a dependency.

Update 25/06/2015: the Vagrant box now uses a *host-only* interface instead of
a *bridged* one. If you built a Vagrant box before this date, please destroy
it, recreate a new one and reprovision it with the provided playbooks.

### To Do List ###

* Implement backup
* Detail physical installation procedure for the server machine within the
  Wiki.

[bglug]: http://bglug.it/ "BgLUG Homepage"
[wiki]: https://github.com/bglug-it/server-config/wiki "server-config wiki"
[ansible]: http://www.ansible.com
[nethserver]: http://www.nethserver.org
[vagrant]: http://www.vagrantup.com
[samba]: https://www.samba.org
[centos]: https://www.centos.org 
