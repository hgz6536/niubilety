#!/usr/bin/python
# coding=utf-8
import memcache

host_list=['192.168.2.91', '192.168.2.92', '192.168.2.93', '192.168.2.101']
for ip in host_list:
    conn = memcache.Client([ip + ':11211'],debug=1)
    host_ip = conn.get('myip')
    test_key = conn.get('a')
    if test_key == None:
        conn.set('a',0,time=600)
    else:
        conn.set('a',int(test_key)+1,time=600)
    if host_ip != None:
        print conn.get('myip') + ':' + str(conn.get('a'))
    else:
        conn.set('myip', ip, time=0)
        print conn.get('myip') + ':' + str(conn.get('a'))
