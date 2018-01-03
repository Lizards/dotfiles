#!/bin/bash
set -e

function main {
    OPTS="$@"
    if [ "${OPTS}" = "" ]; then
        OPTS="--rm"
    fi

    echo -e "Launching lizards/spotify container"

    XCOOKIE=`xauth list | grep unix | cut -f2 -d"/" | tr -cd '\11\12\15\40-\176' | sed -e 's/  / /g'`
    set -x
    docker run $OPTS --name spotify \
        `# Display` \
        --device /dev/dri \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -e DISPLAY=unix$DISPLAY \
        -e XCOOKIE="${XCOOKIE}" \
        `# Sound ` \
        -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
        -v $XDG_RUNTIME_DIR/pulse/native:$XDG_RUNTIME_DIR/pulse/native:ro \
        `# dbus (notifications)` \
        -v /run/dbus:/run/dbus:ro \
        -v $XDG_RUNTIME_DIR/bus:$XDG_RUNTIME_DIR/bus:ro \
        -e DBUS_SESSION_BUS_ADDRESS \
        `# User settings` \
        -v $HOME/.spotify/config:/home/user/.config/spotify \
        -v $HOME/.spotify/cache:/home/user/.cache/spotify \
        `# Supply if UID/GID is not 1000` \
        -e USER_UID=$(id --user) \
        -e USER_GID=$(id --group) \
        lizards/spotify \
        --force-device-scale-factor=1.5
    set +x
}
main $@
