#!/usr/bin/env python
# coding=utf-8
#     /?\__/?\              #$$$$$$$
#   <( *   *  )>           #       &)
#    ( @ @ )  -------?    #&&&&&&&)
#      ~    \        $\  #        &)
#           &\.;----/ \ #$$$$$$$$$
# Mywblog: www.niubilety.com
# Email: hgz@niubilety.com

import datetime, subprocess, os, sys, logging, argparse

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s', datefmt='',filename='mybak.log',
                    filemode='a')

backuser = 'root'
backpwd = '123456'
basedir = '/data/backups'

fullback_pre = 'full'
dic = {'day': '24', 'hour': '1', 'week': '168', 'month': '720'}


cuhour = datetime.datetime.now().strftime("%H")
todaydate = datetime.datetime.now().strftime("%Y%m%d")

parser = argparse.ArgumentParser()
parser.add_argument('-f', '--full', action='store', help='full bakup interval')
parser.add_argument('-i', '--inc', nargs='+', action='store', help='incremental bakup interval,mintime one hour.')
args = parser.parse_args()
if args.full == 'day':
    fullback_dir = "%s/%s/%s" %(basedir, todaydate, fullback_pre)
#if args.inc[0] in
print(args.inc)
