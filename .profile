#!/bin/bash

export VISUAL="/bin/vim"
export EDITOR="/bin/vi -e"
export SYSTEMD_EDITOR="${VISUAL}"

export HISTSIZE=500000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL="ignoredups"

export POLYBAR_BARS="right"
export POLYBAR_WLAN_INTERFACE="wlp5s0"
export POLYBAR_ETH_INTERFACE="enp0s3"

export MONITOR="Virtual-1"

export DOCKER_SPOTIFY_FORCE_DEVICE_SCALE_FACTOR="2.0"
export DOCKER_SLACK_FORCE_DEVICE_SCALE_FACTOR="2.0"

VBoxClient-all
