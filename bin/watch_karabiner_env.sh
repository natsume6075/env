#!/bin/sh
# see also http://mizti.hatenablog.com/entry/2013/01/27/204343

update() {
  echo `openssl sha256 -r /Library/Application\ Support/org.pqrs/tmp/karabiner_grabber_manipulator_environment.json | awk '{print $1}'`
}

INTERVAL=0.5 #監視間隔, 秒で指定
no=0
last=`update $1`
while true;
do
  sleep $INTERVAL
  current=`update $1`
  if [ "$last" != "$current" ];
  then
    nowdate=`date '+%Y/%m/%d'`
    nowtime=`date '+%H:%M:%S'`

    while read line
    do
      line=${line//,/}
      if [[ "$line" == "\"current_mode\": "* ]]; then
        if [[ "$line" == "\"current_mode\": 0" ]]; then
          echo "set current_mode to 0"
        elif [[ "$line" == "\"current_mode\": 1" ]]; then
          echo "set current_mode to 1"
        elif [[ "$line" == "\"current_mode\": 2" ]]; then
          echo "set current_mode to 2"
        fi
      fi
      if [[ "$line" == "\"is_fn_lock\": "* ]]; then
        if [[ "$line" == "\"is_fn_lock\": 0" ]]; then
          echo "set is_fn_lock to 0"
        elif [[ "$line" == "\"is_fn_lock\": 1" ]]; then
          echo "set is_fn_lock to 1"
        fi
      fi
    done < /Library/Application\ Support/org.pqrs/tmp/karabiner_grabber_manipulator_environment.json

    last=$current
    no=`expr $no + 1`
  fi
done
