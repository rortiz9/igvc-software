#!/bin/bash
#Moves file containing udev rules for addressing sensors to appropriate folder

sudo cp ../udev/igvc_2012.rules /etc/udev/rules.d/
sudo service udev restart
exit
$SHELL
