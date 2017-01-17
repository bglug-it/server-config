#!/bin/bash

# Define a fix name. This will be used to check if the fix was already
# applied.
name=samba-downgrade_20161124.sh

# If already applied, skip
if [[ -f "/var/lib/topolin.ia/fixes/${name}.done" ]]; then
  echo "Already fixed with ${name}. Skipping."
  exit 0
fi

# Make the required modifications.

export DEBIAN_FRONTEND=noninteractive
apt-get install -q -y --force-yes \
-o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
libsmbclient=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
python-samba=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
samba=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
samba-common=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
samba-common-bin=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
samba-dsdb-modules=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
samba-libs=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
samba-vfs-modules=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
smbclient=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
libnss-winbind=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
libpam-winbind=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
libwbclient0=2:4.3.11+dfsg-0ubuntu0.14.04.1 \
winbind=2:4.3.11+dfsg-0ubuntu0.14.04.1

pkglist="libsmbclient python-samba samba-common samba-common-bin samba-dsdb-modules samba-libs samba-vfs-modules smbclient libnss-winbind libpam-winbind libwbclient0"

for pkg in ${pkglist}; do
  apt-mark auto ${pkg}
  apt-mark hold ${pkg}
done

# Once modified the system, ensure to create a check file to skip and not run
# it again if not needed.
mkdir -p /var/lib/topolin.ia/fixes
echo "$(date --iso | tr -d '-')" > /var/lib/topolin.ia/fixes/${name}.done
