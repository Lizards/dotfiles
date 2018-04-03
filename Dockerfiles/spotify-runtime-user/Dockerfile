# Run spotify in a container using pulseaudio and X11 magic cookie, creating spotify user at runtime in case of UID/GID mismatch
#
# Combined efforts of:
# https://github.com/jessfraz/dockerfiles/blob/master/spotify/Dockerfile
# https://github.com/syncomm/dockerfiles/tree/master/spotify
# https://github.com/terlar/docker-skype-pulseaudio
#
# docker build -t lizards/spotify .
#
# docker run --rm --detach --name spotify \
#     `# Display (required)` \
#     -e DISPLAY \
#     -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
#     `# Display (optional)` \
#     --device /dev/dri \
#     -e XCOOKIE="$(xauth list | grep unix | cut -f2 -d"/" | tr -cd '\11\12\15\40-\176' | sed -e 's/  / /g')" \
#     `# Sound (required, first two will work for some people, second two for others)` \
#     --device /dev/snd \
#     --group-add $(getent group audio | cut -d: -f3) \
#     -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
#     -v $XDG_RUNTIME_DIR/pulse/native:$XDG_RUNTIME_DIR/pulse/native:ro \
#     `# dbus to enable desktop notifications (optional)` \
#     -v /run/dbus:/run/dbus:ro \
#     -v $XDG_RUNTIME_DIR/bus:$XDG_RUNTIME_DIR/bus:ro \
#     -e DBUS_SESSION_BUS_ADDRESS \
#     `# Mount volumes for config and cache (optional, must create local directories first)` \
#     -v $HOME/.spotify/.config:/home/spotify/.config/spotify \
#     -v $HOME/.spotify/.cache:/home/spotify/.cache/spotify \
#     `# Supply if UID/GID is not 1000` \
#     -e USER_UID=$(id --user) \
#     -e USER_GID=$(id --group) \
#     lizards/spotify \
#     `# Spotify app flags here`
#     --force-device-scale-factor=1.5

FROM debian:buster

ARG USER=spotify
ENV USERNAME $USER
ENV HOME /home/$USER

RUN apt-get update && apt-get install -y \
    dirmngr \
    gnupg \
    --no-install-recommends \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410 \
    && echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list \
    && apt-get update && apt-get install -y \
    sudo \
    xauth \
    xdg-utils \
    alsa-utils \
    pulseaudio \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libpangoxft-1.0-0 \
    libnotify-bin \
    spotify-client \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p $HOME/.config \
    && mkdir -p $HOME/.cache

ADD entrypoint.sh /usr/bin/entrypoint
ENTRYPOINT ["/usr/bin/entrypoint", "spotify"]
CMD []
