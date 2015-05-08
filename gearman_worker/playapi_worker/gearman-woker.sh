#!/bin/bash
#################################################
#Make by hunter
#QQ:847644968
#Date:20140404 last update
#################################################
source /etc/profile
php_file=/data/tuziparser/www/index.php
worker_max=`free | awk '/Mem/ {print int($2/1024/8)}'`
worker_num=`expr $worker_max / 2`
let advice_worker_num=$worker_num+`expr $worker_num / 2`
help()
{
echo "
One worker need 8M memory,so we can get worker max num =$worker_max,bu it use all of mem of the system,
you know that will not be allowed.so,we can get safe worker num =$worker_num ,yes! it is max num 1/2.
But this num is too low to this system, so we advice num=$advice_worker_num.
this number = safe worke num + safe worke num/2, I think this number is ok!
"
}
case $1 in
	start )
		n_worker_num=`ps -ef |grep php|grep -v grep|wc -l`
		let u_worker_num=$n_worker_num+$2
		if [ $u_worker_num -ge $advice_worker_num ];then
			echo "There will be $u_worker_num workers is biger than advice number,
			please reset it!
			"
			exit 250
		else
			i=0
			while [ $i -lt $u_worker_num ]
			do
				php -f $php_file worker=true >>/dev/null 2>&1 &
				((i+=1))
			done
			echo "you start $2 workers,there is $u_worker_num workers in this system"
		fi
		;;
	kill )
		ps -ef |grep php|grep -v grep|head -n $2 |awk '{print $2}' |xargs kill -9
		if [ $? = 0 ];then
			echo "$2 worker killed successfully"
			sleep 3
			n_worker_num=`ps -ef |grep php|grep -v grep|wc -l`
			echo "There is $n_worker_num workers still working"
		else
			echo "kill Fail, please do it by yourself"
		fi
		;;
	killall )
		killall php
		sleep 1
		wo_num=`ps -ef |grep php|grep -v grep|wc -l`
		echo "There is $wo_num workers in this system!"
		;;
	restart )
		c_worker_num=`ps -ef |grep php|grep -v grep|wc -l`
		killall php && sleep 1
		if [ $c_worker_num = 100 ];then
			$0 start $c_worker_num
		else
			$0 start 100
		fi
		;;
	* )
		help
		echo "$0 [start|kill] num or $0 killall or $0 restart
		"
		;;
esac
