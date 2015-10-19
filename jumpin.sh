#!/bin/bash
USERGROUP="gulpgrp"
USERNAME="gulp"
USERHOME="/home/$USERNAME"

# ensure $UID and $GID are set
if [[ -z $UID ]]; then
    echo "Please specify environment variable UID (eg: -e UID=\$(id -u))"
    exit 1
elif [[ -z $GID ]]; then
    echo "Please specify environment variable GID (eg: -e GID=\$(id -g))"
    exit 1
fi

# create user and group
mkdir -p $USERHOME
groupadd -g "$GID" -r "$USERGROUP"
useradd -u "$UID" -r -g "$USERGROUP" -s /bin/bash "$USERNAME"
chown -R $USERNAME:$USERGROUP $USERHOME

# kick off gulp with passed in args as user
su --login "$USERNAME" -c "cd $GULP_SOURCE_DIR && $*"
