#!/bin/bash

FILE="$1"
ssh root@203.78.107.234 -p6789 'bash -s' < "$FILE";

DIR=/home/managene

# change owner (public_html)
if [ -d "$DIR" ]; then
    cd /home/managene/;
    git status;
    git config --global user.email "prasit@netway.co.th"
    git config --global core.fileMode false
    git config --global credential.helper store
    git reset --hard;
    git pull;
fi

cd /home/managene/;
chown managene:managene -R google-cli
chown managene:managene -R public_html;
chown managene:nobody public_html;

#migrate script
FILE=/home/managene/migrate/migrate_script.php
if [ -e "$FILE" ]; then
    php $FILE;
else
    echo "$FILE not exists";
fi