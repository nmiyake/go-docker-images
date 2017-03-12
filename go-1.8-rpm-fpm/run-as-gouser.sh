#! /bin/sh

# set the UID of gouser to be the value of $USER_ID
if [ "$(id -u gouser)" -ne "$USER_ID" ]; then
  usermod -u $USER_ID gouser
  chown -R gouser /go
fi

su -c "$@" gouser
