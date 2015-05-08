#!/usr/bin/env python
# coding=utf-8
#import os, sys
import ConfigParser
import socket
config = ConfigParser.ConfigParser()

class Get_data:
    def __init__(self,ini_file):
        self.ini_file = ini_file
        config.read(ini_file)

    def Show_section(self):
        self.section = config.sections()
        return self.section

    def Show_option(self,section):
        self.option = config.options(section)
        return self.option

    def Show_option_data(self,section,option):
        self.option_data = config.get(section,option)
        return self.option_data

    def Show_section_data(self,section):
        host_list = []
        option_list = config.options(section)
        for i in option_list:
            ip = config.get(section,i)
            host_list.append(ip)
        return sorted(host_list, key = socket.inet_aton)

    def Show_all_data(self):
        all_host_list = []
        section_list = config.sections()
        for i in section_list:
            option_list = config.options(i)
            for j in option_list:
                ip = config.get(i,j)
                all_host_list.append(ip)
        return sorted(all_host_list, key = socket.inet_aton)

'''
if __name__ == "__main__":
    getdata = Get_data('./host.ini')
    #getdata.Show_section()
    #getdata.Show_option('mysql-host')
    print getdata.Show_option_data('api-host','node1')
    #getdata.Show_section_data('mysql-host')
    #getdata.Show_all_data()
'''
