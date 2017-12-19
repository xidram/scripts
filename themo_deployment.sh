#!/bin/bash

ROOT_DIR='/home/ilan/tmp'
WEB_DIR="$ROOT_DIR/themo_web"
WEB_DIR_BACKUP="$WEB_DIR.prev"

# root dir exists?
if [ ! -d "$ROOT_DIR" ]; then
  echo "-E- can't access: $DIRECTORY"
  exit
fi

cd $ROOT_DIR

# delete previous backup if exists
if [ -d "$WEB_DIR_BACKUP" ]; then
  echo "-I- removing existing backup"
  rm -rf $WEB_DIR_BACKUP
fi

# backup current version
if [ -d "$WEB_DIR" ]; then
  echo "-I- creating new backup"
  mv "$WEB_DIR" "$WEB_DIR_BACKUP"
fi


git clone https://github.com/marinetech/themo_web.git
if [ ! -d "$WEB_DIR" ]; then
  echo "-E- git clone failed"
  exit
fi
cd $WEB_DIR
echo "-I- npm install"
npm install
#pm2 restart server
