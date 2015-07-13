#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Crypto.Hash import MD5
from Crypto.Cipher import AES
from base64 import b64decode
from requests import get
from socket import gethostname
from os import makedirs, path

key = MD5.new(gethostname()).digest()
cipher = AES.new(key, AES.MODE_ECB)
base64enc = get("http://{{ serverfqdn }}:3000/vaultpass")
encrypted = b64decode(base64enc.content)
longpass = cipher.decrypt(encrypted)

if not path.exists('/root/.ansible'):
  makedirs('/root/.ansible')

with open('/root/.ansible/vault.txt', 'w+') as vaultfile:
  vaultfile.write(longpass.strip('x'))
