# Default password for project #

* NS Box root user:	`vagrant`
* NS Box vagrant user:	`vagrant`
* Vault Password: 	`v4ul+Password!`
* amgmt user (server): 	`DoN0t4g3t!`
* bglug user (client): 	`s4lamanDr@`
* admin user (domain): 	`R0busTdom41nPa55wd!`

# How to change passwords for production deployments #

## *root* and *vagrant* users ##

These will not be required, since you will not have a virtual machine to
manage via *Vagrant*.

## Vault password ##

Clone [`client-pull-installation`][2] then, in the working copy, launch following commands:

	$ ansible-vault rekey domainpwd.vault

`ansible-vault` will ask one time the old password and two times the new one.

## *amgmt* user (server-side) ##

Clone [`server-config`][1] then, in the working copy, generate a new password hash with the follwing command:

	$ mkpasswd -m sha-512

The command would ask for the password to be hashed. Please copy the result string.

Open up the file `roles/init/tasks/mgmtuser.yml`, find out `password:` and then replace previous hash with the one you have just created.

## *bglug* user (client side but preseeded) ##

The definition of password for *bglug* is inside `*.seed` files, inside [`server-config`][1]. Create a new password hash with:

	$ mkpasswd -m sha-512

Copy the hash in your clipboard; clone the repository, then in the working directory:

	$ find . -iname \*.seed -exec $EDITOR {} \;
	
Within each `*.seed` file, search for the string `user-password-crypted` string and change following hash.

## *admin* user (domain valid) ##

Password must be specified within NethServer interface for the *admin* user and must be absolutely equal to the one contained inside vault file.

Clone [`client-pull-installation`][2], create new branch and modify the password inside `domainpwd.vault`:

	$ ansible-vault edit domainpwd.vault

The system would ask for the vault password. Change the plain text password with your editor.

[1]: https://github.com/bglug-it/server-config
[2]: https://github.com/bglug-it/client-pull-installation
