# VLC media player with X11 magic cookie support
#
# docker build -t lizards/vlc .
#
# docker run --rm --detach --name vlc \
#     -v /etc/localtime:/etc/localtime:ro \
#     `# Display` \
#     --device /dev/dri \
#     -e DISPLAY \
#     -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
#     -e XCOOKIE="$(xauth list | grep unix | cut -f2 -d"/" | tr -cd '\11\12\15\40-\176' | sed -e 's/  / /g')" \
#     `# Sound` \
#     -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
#     -v $XDG_RUNTIME_DIR/pulse/native:$XDG_RUNTIME_DIR/pulse/native:ro \
#     `# dbus (optional)` \
#     -v /run/dbus:/run/dbus:ro \
#     -v $XDG_RUNTIME_DIR/bus:$XDG_RUNTIME_DIR/bus:ro \
#     -e DBUS_SESSION_BUS_ADDRESS \
#     `# Mount volume containing media` \
#     -v $HOME:/media:ro \
#     `# Mount volume for config (optional)` \
#     -v $HOME/.vlc/.config:/home/vlc/.config \
#     `# Workaround using ENTRYPOINT and CMD to add magic cookie` \
#     --entrypoint '/bin/bash' \
#     lizards/vlc \
#     -c 'touch ~/.Xauthority && xauth add $XCOOKIE && vlc'

FROM jess/vlc

USER root
RUN apt-get update && apt-get install -y \
    xauth \
    vlc-plugin-access-extra \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR $HOME
USER vlc
ENTRYPOINT ["vlc"]
CMD []
