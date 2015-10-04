#!/bin/bash

domaingroup="domain users"
localgroups="pulse pulse-access"

baseusers="bglug"
domainusers="$(getent group "${domaingroup}" | awk 'BEGIN { FS = ":" } ; { print $4 }' | sed -e 's/,/ /g')"

users="${baseusers} ${domainusers}"

for group in ${localgroups}; do
  actualusers=$(getent group '${group}' | awk 'BEGIN { FS = ":" }; { print $4 }' | sed -e 's/,/ /g')

  # Removing users not in the group
  for user in ${actualusers}; do
    whuser=${user//[[:space:]]/}
    echo "removing ${user}"
    [[ "${users}" =~ "${whuser}" ]] || gpasswd -d "${whuser}" "${group}"
    unset whuser
  done

  # Adding users to group
  for user in ${users}; do
    whuser=${user//[[:space:]]/}
    [[ "${actualusers}" =~ "${whuser}" ]] || gpasswd -a "${whuser}" "${group}"
  done
done
