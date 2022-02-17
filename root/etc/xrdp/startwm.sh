#!/bin/bash
# Disable the following line below on macOS
PULSE_SCRIPT=/etc/xrdp/pulse/default.pa /startpulse.sh &
# OR:
# PULSE_SCRIPT=/etc/xrdp/pulse/default.pa /startpulse.sh --start &
# Start a openbox session
/usr/bin/openbox-session > /dev/null 2>&1
# Start a xfce4 desktop
#/usr/bin/startxfce4 > /dev/null 2>&1
