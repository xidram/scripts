#!/bin/bash

LOG_NAME=/home/ilan/logs/bu353.log

if [ -f $LOG_NAME ]; then
  rm $LOG_NAME
fi

while :
  do
     echo >> $LOG_NAME
     echo -------------------------------------------------------------- >> $LOG_NAME
     date >> $LOG_NAME
     stty -F /dev/ttyUSB0 ispeed 4800 && cat < /dev/ttyUSB0 >> $LOG_NAME
     sleep 1
     echo "Press [CTRL+C] to stop.."
  done
