#!/bin/sh

echo "$@" | socat - "UNIX-CLIENT:/run/user/${UID}/xdg-open-server/socket$(echo "${DISPLAY}" | sed -r 's/\\/\\\\/g' | sed -r 's/:/\\:/g')"
