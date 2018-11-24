#!/bin/bash

export VISUAL="/bin/vim"
export EDITOR="/bin/vi -e"
export SYSTEMD_EDITOR="${VISUAL}"

export HISTSIZE=500000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL="ignoredups"

export POLYBAR_BARS="x1internal x1external"
export POLYBAR_WLAN_INTERFACE="wlp2s0"
export POLYBAR_ETH_INTERFACE="enp0s20f0u2"
export POLYBAR_XWINDOW_LABEL="%title:0:82:...%"

export DOCKER_SPOTIFY_FORCE_DEVICE_SCALE_FACTOR="1.5"
export DOCKER_SLACK_FORCE_DEVICE_SCALE_FACTOR="1.75"
