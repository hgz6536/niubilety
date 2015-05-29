#!/bin/bash

#It's used to save and delete old log file of nginx
Time=`date +%Y%m%d`
Dir=/data/logs/nginx
nginx_path=/usr/local/openresty/nginx
#start the job
cd $Dir && /usr/bin/rename .log  .log-$Time *.log && /bin/kill -USR1 `cat $nginx_path/logs/nginx.pid`
if [ $? = 0 ];then
  echo "log success!!"
 else
  echo "log faild!!!"
fi

#now delete old bakup log
Old_day=`date +%Y%m%d --date='3 days ago'`
testlog=`/bin/find ./ -name *-$Old_day|wc -l`
if [ $testlog != 0 ];then
  rm -rf *-$Old_day
 else
  echo "no old log to del..."
fi
