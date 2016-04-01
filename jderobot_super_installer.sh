#!/bin/bash
#
# Copyright (c) 2016
# Author: Victor Arribas <v.arribas.urjc@gmail.com>
# License: GPLv3 <http://www.gnu.org/licenses/gpl-3.0.html>
#
# JdeRobot super installer
#   it just install binary packages for execution and develop out of de box.
#   install jderobot-deps-dev if you also want to develop inside.

set -e

if [ "$USER" != "root" ]; then
    echo "you must run it as root"
    exit 1
fi

test -z "$(which apt-fast)" \
    && echo "Install apt-fast for extra speed up" \
    && apt-get install -y git make \
    && target=/tmp/git/apt-fast \
    && git clone https://github.com/varhub/apt-fast.git -b 1.8.4 $target \
    && cd $target \
    && make install

echo "JdeRobot bin" \
    && apt-fast install -y wget lsb-release \
    && echo "deb http://packages.osrfoundation.org/gazebo/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/gazebo-latest.list \
    && wget -q http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
    && echo "deb http://ppa.launchpad.net/v-launchpad-jochen-sprickerhof-de/pcl/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/jochen-sprickerhof-pcl.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 19274DEF \
    && echo "deb http://jderobot.org/apt trusty main" > /etc/apt/sources.list.d/jderobot.list \
    && wget -q http://jderobot.org/apt/jderobot-key.asc -O - | apt-key add - \
    \
    && apt-get update \
    && apt-fast install -y --force-yes libqwt5-qt4-dev liblcms2-2=2.5-0ubuntu4 jderobot \
    \
    && wget -q 'https://raw.githubusercontent.com/jderobot-varribas/jderobot-post-install/master/jderobot-post-install.sh' -O /usr/local/bin/jderobot-post-install \
      && chmod 0755 /usr/local/bin/jderobot-post-install

