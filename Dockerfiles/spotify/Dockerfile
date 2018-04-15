# Spotify with X11 magic cookie support
#
# docker build -t lizards/spotify .
#
# docker run --rm --detach --name spotify \
#     -v /etc/localtime:/etc/localtime:ro \
#     `# Display` \
#     --device /dev/dri \
#     -e DISPLAY \
#     -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
#     -e XCOOKIE="$(xauth list | grep unix | cut -f2 -d"/" | tr -cd '\11\12\15\40-\176' | sed -e 's/  / /g')" \
#     `# Sound` \
#     -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
#     -v $XDG_RUNTIME_DIR/pulse/native:$XDG_RUNTIME_DIR/pulse/native:ro \
#     `# dbus (optional, for notifications)` \
#     -v /run/dbus:/run/dbus:ro \
#     -v $XDG_RUNTIME_DIR/bus:$XDG_RUNTIME_DIR/bus:ro \
#     -e DBUS_SESSION_BUS_ADDRESS \
#     `# User mounts` \
#     -v $HOME/.spotify/.config:/home/spotify/.config \
#     -v $HOME/.spotify/.cache:/home/spotify/.cache \
#     `# Workaround using ENTRYPOINT and CMD to add magic cookie` \
#     --entrypoint '/bin/bash' \
#     lizards/spotify \
#     -c 'touch ~/.Xauthority && xauth add $XCOOKIE && spotify --force-device-scale-factor=2.0'

FROM jess/spotify

USER root
RUN apt-get update && apt-get install -y \
    xauth \
    socat \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR $HOME
USER spotify
ENTRYPOINT ["spotify"]
CMD []
