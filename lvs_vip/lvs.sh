#!/bin/bash
#把一下内容保存成:lvs_real_server.sh
#并放置在/etc/init.d目录下
#如果想启动LVS Real Server执行:/etc/init.d/lvs_real_server.sh start
#如果想停止LVS Real Server执行:/etc/init.d/lvs_real_server.sh stop
#如果想查看LVS Real Server状态:/etc/init.d/lvs_real_server.sh stop

VIP=192.168.2.168
VIP1=192.168.2.166

. /etc/rc.d/init.d/functions # 如果提示权限不够，那么先在命令行执行: chmod 777 /etc/rc.d/init.d/functions

case "$1" in

start)
       ifconfig lo:0 $VIP netmask 255.255.255.255 broadcast $VIP
       ifconfig lo:1 $VIP1 netmask 255.255.255.255 broadcast $VIP1
       /sbin/route add -host $VIP dev lo:0
       /sbin/route add -host $VIP1 dev lo:1
       echo "1" >/proc/sys/net/ipv4/conf/lo/arp_ignore
       echo "2" >/proc/sys/net/ipv4/conf/lo/arp_announce
       echo "1" >/proc/sys/net/ipv4/conf/all/arp_ignore
       echo "2" >/proc/sys/net/ipv4/conf/all/arp_announce
       sysctl -p >/dev/null 2>&1
       echo "RealServer Start OK"
       ;;
	   
stop)
       ifconfig lo:0 down
       ifconfig lo:1 down
       route del $VIP >/dev/null 2>&1
       route del $VIP1 >/dev/null 2>&1
       echo "0" >/proc/sys/net/ipv4/conf/lo/arp_ignore
       echo "0" >/proc/sys/net/ipv4/conf/lo/arp_announce
       echo "0" >/proc/sys/net/ipv4/conf/all/arp_ignore
       echo "0" >/proc/sys/net/ipv4/conf/all/arp_announce
       echo "RealServer Stoped"
       ;;
	   
status)
        #Status of LVS-DR real server.
        islothere=`/sbin/ifconfig lo:0 | grep $VIP`
        isrothere=`netstat -rn | grep "lo:0" | grep $VIP`
        if [ ! "$islothere" -o ! "isrothere" ];then
            # Either the route or the lo:0 device
            # not found.
            echo "LVS-DR real server Stopped."
        else
            echo "LVS-DR Running."
        fi
;;

*)
        #Invalid entry.
        echo "$0: Usage: $0 {start|status|stop}"
        exit 1
;;
esac
exit 0
