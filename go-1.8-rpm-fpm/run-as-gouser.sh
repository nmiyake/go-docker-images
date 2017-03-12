#! /bin/sh

# set the UID of gouser to be the value of $USER_ID
if [ "$(id -u gouser)" -ne "$USER_ID" ]; then
  usermod -u $USER_ID gouser
  chown -R gouser /go
fi

# execute provided command in a manner that maintains environment variables of root.
# The PATH variable is changed on execution, so re-add Go paths.
su -c "PATH=$GOPATH/bin:/usr/local/go/bin:$PATH; $@" gouser
