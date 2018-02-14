#!/bin/bash

### BEGIN INIT INFO
 # Provides:          noip
 # Required-Start:    $remote_fs $syslog
 # Required-Stop:     $remote_fs $syslog
 # Default-Start:     2 3 4 5
 # Default-Stop:      0 1 6
 # Short-Description: Simple script to start a program at boot
 ### END INIT INFO

GPSDATE=`gpspipe -w | head -10 | grep TPV | sed -r 's/.*"time":"([^"]*)".*/\1/' | head -1`
echo $GPSDATE
date -s "$GPSDATE"
/usr/sbin/ntpd

exit 0
