#!/usr/bin/env python

"""API to map MAC addresses to hostnames"""

from contextlib import contextmanager, closing
from sqlite3 import connect
from bottle import route, run, request
from json import dumps
import os

__author__ = "Enrico Bacis"
__email__ = "enrico.bacis@gmail.com"

# Aggiunta di Emiliano Vavassori <syntaxerrormmm-AT-gmail.com>
# Configuring default directories for the program
dbdir = '/var/lib/mac2hostname'
logdir = '/var/log/mac2hostname'
piddir = '/var/run/mac2hostname'

# Will create a PID file to be used with init.d script
pid = os.getpid()
op = open(piddir + '/service.pid', 'w')
op.write("%s" % pid)
op.close()

@contextmanager
def getcursor(db = dbdir + 'mac2hostname.db'):
    with connect(db) as connection:
        with closing(connection.cursor()) as cursor:
            yield cursor

def init_tables():
    with getcursor() as cursor:
        cursor.execute('CREATE TABLE IF NOT EXISTS client (id INT PRIMARY KEY,'
                       'hostname TEXT NOT NULL UNIQUE, mac TEXT UNIQUE)')
        cursor.execute('CREATE INDEX IF NOT EXISTS idxmac ON client(mac)')

@route('/hosts')
def hosts():
    with getcursor() as cursor:
        return dumps([dict((meta[0], data)
                      for meta, data in zip(cursor.description, row))
                      for row in cursor.execute('SELECT hostname, mac FROM client ORDER BY id')], indent=4)

def normalizemac(mac):
    return ':'.join(x.zfill(2) for x in mac.split(':')).upper()

def gethostname(mac, base=None):
    mac, base = normalizemac(mac), base or 'lab'
    with getcursor() as cursor:
        (newid,) = cursor.execute('SELECT COALESCE(MAX(id)+1, 1) FROM client').fetchone()
        cursor.execute('INSERT OR IGNORE INTO client VALUES (%s, "%s-%s", "%s")' % (newid, base, newid, mac))
        (hostname,) = cursor.execute('SELECT hostname FROM client WHERE mac = "%s"' % mac)
    return hostname

@route('/mac2hostname')
def mac2hostname():
    mac = request.query.mac
    if not mac:
        return 'Usage: GET /mac2hostname?mac=XX_XX_XX_XX_XX_XX[&base=YYY]'
    return gethostname(mac, base)

if __name__ == '__main__':
    init_tables()
    run(host='0.0.0.0', port=3000)
