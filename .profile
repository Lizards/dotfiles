#!/bin/bash

export VISUAL="/bin/vim"
export EDITOR="/bin/vi -e"
export SYSTEMD_EDITOR="${VISUAL}"

export HISTSIZE=500000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL="ignoredups"

export POLYBAR_BARS="w540internal w540external"
export POLYBAR_WLAN_INTERFACE="wlp3s0"
export POLYBAR_ETH_INTERFACE="enp0s25"

export DOCKER_SPOTIFY_FORCE_DEVICE_SCALE_FACTOR="2.0"
export DOCKER_SLACK_FORCE_DEVICE_SCALE_FACTOR="1.75"
