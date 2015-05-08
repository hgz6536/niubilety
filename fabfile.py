#!/usr/bin/env python
# coding=utf-8
#from fabric.operations import *
from fabric.api import *
from config import Get_data
from fabric.contrib.console import confirm
from fabric.colors import *
import sys

sys.path.append("/root/niubilety")
getdata = Get_data('/root/niubilety/host.ini')

env.roledefs = {
    'api-host':getdata.Show_section_data('api-host'),
    'mem-host':getdata.Show_section_data('mem-host'),
    'man-host':getdata.Show_section_data('man-host'),
    'mysql-host':getdata.Show_section_data('mysql-host'),
    'worker-host':getdata.Show_section_data('worker-host'),
    'suzhu-host':getdata.Show_section_data('suzhu-host'),
    'all-host':getdata.Show_all_data()
}

@roles('api-host')
def nginx_test():
    with settings(
        hide('running'),
        warn_only=True
        ):
        run('/usr/local/openresty/nginx/sbin/nginx -t')

def tmp_cli(cli='ls'):
    with settings(warn_only=True):
        ex_result = run(cli)
    if ex_result.failed and not confirm(red("command execute faild,go on?")):
	abort(green("Bye"))

def upload(s = '', d = ''):
    with settings(
        hide('running', 'stdout', 'stderr', 'output'),
	warn_only=True
    ):
        put(s, d)

def download(s = '', d = ''):
    with settings(
        hide('running', 'stdout', 'stderr', 'output'),
	warn_only=True
    ):
        get(s, d)

def test():
    with settings(
	hide('running', 'stdout', 'stderr', 'output'),
        warn_only=True
    ):
        result = local('aa', capture=True)
    if result.failed and not confirm(red("Test faild,Continue anyway?")):
        abort(green("Bye"))
