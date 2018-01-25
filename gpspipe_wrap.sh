#!/bin/bash

while :
  do
    gpspipe -r -d -l -o /home/pi/gpsdata/data.`date +%F.%H:%M:%S`.nmea
    sleep 5m
  done

# this wrapper is intended to run on rpi'es that attached to ANL small "GPS buoys"
# gpspipe is a wrapper for gpsd, therefore gpsd/ gpspipe should be installed appropriately on teh rpi
# the idea is that this wrapper will run automatically once the rpi is powered-up. in order to do so, I'll use  /etc/rc.local
