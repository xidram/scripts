#!/bin/bash

function quit {
  echo -E- No connection to backup server
  exit
}

function synch {
  backup_list=( "/home/ilan/projects" "/home/ilan/Desktop" "/home/ilan/.local/share/gnote" "/home/ilan/Documents" "/home/ilan/Pictures")

  for i in "${backup_list[@]}"
  do
     :
     echo $i
     rsync -avzhe ssh $i imardix@132.75.16.15:/home/imardix/backup/
  done

}

ping -q -w 1 -c 1 132.75.16.15 |grep '1 received' > /dev/null && synch || quit
