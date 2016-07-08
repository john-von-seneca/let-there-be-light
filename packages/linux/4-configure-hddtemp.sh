#!/bin/zsh

# https://wiki.archlinux.org/index.php/Hddtemp

sudo mkdir /etc/systemd/system/hddtemp.service.d
"[Service]\nExecStart=\nExecStart=/usr/sbin/hddtemp -dF /dev/sda /dev/sdb /dev/sdc /dev/sdd" >  /etc/systemd/system/hddtemp.service.d/customexec.conf

# Reload systemd's unit files
systemctl daemon-reload

# restart hddtemp
systemctl restart hddtemp.service

# if it fails, then use this to debug
# systemctl status hddtemp.service

