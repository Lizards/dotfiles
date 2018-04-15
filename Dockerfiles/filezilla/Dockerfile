# Filezilla
#
# docker build -t lizards/filezilla .
#
# docker run --rm --detach --name filezilla \
#     `# Display (required)` \
#     -e DISPLAY \
#     -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
#     `# Display (optional)` \
#     --device /dev/dri \
#     -e XCOOKIE="$(xauth list | grep unix | cut -f2 -d"/" | tr -cd '\11\12\15\40-\176' | sed -e 's/  / /g')" \
#     `# dbus to enable desktop notifications (optional)` \
#     -v /run/dbus:/run/dbus:ro \
#     -v $XDG_RUNTIME_DIR/bus:$XDG_RUNTIME_DIR/bus:ro \
#     -e DBUS_SESSION_BUS_ADDRESS \
#     `# xdg-open` \
#     -e UID="$(id --user)" \
#     -v "${XDG_RUNTIME_DIR}/xdg-open-server:${XDG_RUNTIME_DIR}/xdg-open-server:ro" \
#     `# gtk theme` \
#     -v "/usr/share/themes/:/usr/share/themes/" \
#     -v "${HOME}/.gtkrc-2.0:/home/filezilla/.gtkrc-2.0" \
#     `# Mount volumes for config and storage` \
#     -v "${HOME}/.filezilla:/home/filezilla/.config/filezilla" \
#     -v "${HOME}:/host" \
#     lizards/filezilla

FROM debian:buster
LABEL maintainer "<amanda@smart.net>"

ARG USER=filezilla
ENV USERNAME $USER
ENV HOME /home/$USER
ENV NO_SOUND 1

RUN apt-get update && apt-get install -y \
    software-properties-common \
    gnupg \
    sudo \
    xauth \
    socat \
    gtk2-engines-murrine \
    gtk2-engines-pixbuf \
    gnome-themes-standard \
    filezilla \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p $HOME/.config

ADD entrypoint.sh /usr/bin/entrypoint
ENTRYPOINT ["/usr/bin/entrypoint", "filezilla"]
CMD []
