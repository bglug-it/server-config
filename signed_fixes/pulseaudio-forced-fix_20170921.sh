#!/bin/bash

# Define a fix name. This will be used to check if the fix was already
# applied.
name=pulseaudio-force-fix_20170921.sh

# If already applied, skip
if [[ -f "/var/lib/liceo.svbg/fixes/${name}.done" ]]; then
  echo "Already fixed with ${name}. Skipping."
  exit 0
fi

# Make the required modifications.

# Executing the pulseaudio fix for the first time.
curl -sSL http://pdc.liceo.svbg/ks/preseed/pulseaudio-perms.sh | bash

# Creating entry in crontab to be executed each time
echo '@reboot root curl -sSL http://pdc.liceo.svbg/ks/preseed/pulseaudio-perms.sh | bash > /dev/null 2>&1' > /etc/cron.d/pulseaudio-perms
chown root:root /etc/cron.d/pulseaudio-perms
chmod 644 /etc/cron.d/pulseaudio-perms

# Once modified the system, ensure to create a check file to skip and not run
# it again if not needed.
mkdir -p /var/lib/liceo.svbg/fixes
echo "$(date --iso | tr -d '-')" > /var/lib/liceo.svbg/fixes/${name}.done
