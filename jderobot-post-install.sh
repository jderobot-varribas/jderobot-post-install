#!/bin/sh
#
# Copyright (c) 2015-2016
# Author: Victor Arribas <v.arribas.urjc@gmail.com>
# License: GPLv3 <http://www.gnu.org/licenses/gpl-3.0.html>


# This script injects JdeRobot requirements into Gazebo user settings.
# This step should be done *once* installed. But also each time you
# fetch and compile newest code in order to update these files.
# Notice that cp `-f` could be mandatory instead.
# State: beta.

if [ $# -eq 0 ];
then
_jderobot_bashrc=1
_gazebo_bashrc=1
fi

for i in $#
do
case $1 in
'jderobot') _jderobot_bashrc=1 ;;
'gazebo') _gazebo_bashrc=1 ;;
'gazebo-files') _gazebo_files=1 ;;
esac
done


if [ ${_gazebo_files}0 -ne 0 ]; then
echo 'Copying Gazebo assets to $HOME...'
# Inject cfg files (=Ice configs)
mkdir -p ~/.gazebo/cfg
cp -r /usr/local/share/jderobot/gazebo/plugins/*/*cfg ~/.gazebo/cfg

# Add custom Models
cp -r /usr/local/share/jderobot/gazebo/models ~/.gazebo

# Add custom Worlds
cp -r /usr/local/share/jderobot/gazebo/worlds ~/.gazebo
fi

if [ ${_gazebo_bashrc}0 -ne 0 ]; then
echo 'Injecting Gazebo into environment (.bashrc)...'
grep -q 'gazebo-setup.sh' ~/.bashrc || cat<<EOF>>~/.bashrc
test -z "\$GAZEBO_MASTER_URI" \\
  && source /usr/local/share/jderobot/gazebo/gazebo-setup.sh
EOF
fi
