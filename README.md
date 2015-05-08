# niubilety
#This project to record my working method
##介绍下：
本人战斗在一线的运维一枚，掌管的机器由几台到几十台再到现在的一百多台，重复机械的工作量增加不少，需要改变下现状。这个小项目是利用fabric ，一个命令行工具，其具体的使用方法可以在我的博客：[http://blog.niubilety.com/category/python/fabric](http://blog.niubilety.com/category/python/fabric) 看到
##介绍下目录结构和作用
1. gearman_worker
                |\playapi_worker
                |\voapi_worker
包含了2个项目的gearman管理脚本，现在已经放弃不用，改用supervisor管理
2. hosts
        |\api
        |\web
包含2个项目的/etc/hosts 文件，更改后可用fab 的upload task 分发到相应的群组
3. lvs_vip
          |\lvs.sh
lvs 的真实服务器的VIP 启动脚本
4. memcached
            |\test_mem.py
            |\zabbix_agentd.conf
包含测试memcached 服务器的一个脚本和memcached 服务器zabbix agent的配置文件
5. nginx
        |\api
        |\web
包含2个项目的nginx 所有配置文件
6. php
      |\空，风骚占位
7. rsync
        |\api
        |\web_and_man
2个项目的rsync 配置文件
8. zabbix_agent
              |\mysql_host
mysql 服务器的zabbix agent 配置文件
