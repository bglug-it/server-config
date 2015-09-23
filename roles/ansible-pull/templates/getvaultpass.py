#!/usr/bin/env python
# -*- coding: utf-8 -*-

from Crypto.Hash import MD5
from Crypto.Cipher import AES
from base64 import b64decode
from requests import get
from socket import gethostname
from tempfile import mkstemp
import time
import os

key = MD5.new(gethostname()).digest()
cipher = AES.new(key, AES.MODE_ECB)

for i in range(10):
  try:
    base64enc = get("http://{{ ansible_local.domain.serverfqdn }}:3000/vaultpass")
    break
  except:
    time.sleep(1)

encrypted = b64decode(base64enc.content)
longpass = cipher.decrypt(encrypted)

fd, filename = mkstemp()
os.write(fd, longpass.strip('x'))
os.close(fd)

print(filename)
