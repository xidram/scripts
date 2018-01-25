#!/bin/bash

CURRENT_TIME=`date "+%H%M%S%d%m%y"`
LOG_DIR=/home/gpsdata
LOG_NAME=$LOG_DIR/gps_$CURRENT_TIME.log

if [ ! -d "$LOG_DIR" ]; then
  mkdir -p $LOG_DIR
fi

while :
  do
     echo "Press [CTRL+C] to stop.."
     echo >> $LOG_NAME
     echo -------------------------------------------------------------- >> $LOG_NAME
     date >> $LOG_NAME
     stty -F /dev/ttyUSB0 ispeed 4800 && cat < /dev/ttyUSB0 >> $LOG_NAME
     sleep 1
  done
