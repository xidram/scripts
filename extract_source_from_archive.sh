#!/bin/bash

function usage {
  echo
  echo usage:
  echo -e '\t'$0 ARCHIVE_DIR FILE_NAME
    echo -e '\t'$0 /home/ilan/sea sound_nine_ultimodem-averaged-tabs225m09-201707282230.txt
  echo
  exit 1
}

# Check valid archive ($1)
if [ -z "$1" ]
  then
    echo
    echo "-E- missing 'ARCHIVE_DIR'"
    usage
fi

if [ ! -d $1 ]
  then
      echo
      echo -e "-E- $1 not a directory"
      usage
fi

# Check filename is given ($2)
if [ -z "$2" ]
  then
    echo
    echo "-E- missing 'FILE_NAME'"
    usage
fi

for f in `ls $1/*7z`
  do
    OUTPUT=`7za l $f|grep $2`
    if [ ! -z "$OUTPUT" ]
      then
        7za e $f $2 -so |less
        exit 0
    fi
done



# WEB_DIR="$ROOT_DIR/themo_web"
# WEB_DIR_BACKUP="$WEB_DIR.prev"
#
# # root dir exists?
# if [ ! -d "$ROOT_DIR" ]; then
#   echo "-E- can't access: $DIRECTORY"
#   exit
# fi
#
# cd $ROOT_DIR
#
# # delete previous backup if exists
# if [ -d "$WEB_DIR_BACKUP" ]; then
#   echo "-I- removing existing backup"
#   rm -rf $WEB_DIR_BACKUP
# fi
#
# # backup current version
# if [ -d "$WEB_DIR" ]; then
#   echo "-I- creating new backup"
#   mv "$WEB_DIR" "$WEB_DIR_BACKUP"
# fi
#
#
# git clone https://github.com/marinetech/themo_web.git
# if [ ! -d "$WEB_DIR" ]; then
#   echo "-E- git clone failed"
#   exit
# fi
# cd $WEB_DIR
# echo "-I- npm install"
# npm install
# #pm2 restart server
