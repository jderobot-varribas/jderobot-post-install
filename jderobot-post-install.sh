#!/bin/sh

# This script injects JdeRobot requirements into Gazebo user settings.
# This step should be done *once* installed. But also each time you
# fetch and compile newest code in order to update these files.
# Notice that cp `-f` could be mandatory instead.
# State: beta.

# Inject cfg files (=Ice configs)
mkdir -p ~/.gazebo/cfg
cp -r /usr/local/share/jderobot/gazebo/plugins/*/*cfg ~/.gazebo/cfg

# Add custom Models
cp -r /usr/local/share/jderobot/gazebo/models ~/.gazebo

# Add custom Worlds
cp -r /usr/local/share/jderobot/gazebo/worlds ~/.gazebo
