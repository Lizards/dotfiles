#! /bin/bash
set -e

function main() {

    local RED='\e[0;31m'
    local BLUE='\e[1;34m'
    local YELLOW='\e[1;33m'
    local NC='\e[0m'

    # Create user
    groupadd --gid ${USER_GID:-1000} $USERNAME
    useradd \
        --uid ${USER_UID:-1000} \
        --gid ${USER_GID:-1000} \
        --home-dir $HOME \
        --comment "Docker-Spotify-User" \
        $USERNAME
    chown -R $USERNAME:$USERNAME $HOME

    # Verify display settings
    if [ ! -d /tmp/.X11-unix/ ]; then
        echo -e "${RED}[ERROR] * No X11 socket mounted! Connect container to local X server with:${NC}"
        echo
        echo -e "-v /tmp/.X11-unix:/tmp/.X11-unix"
        echo
        exit 1
    fi

    if [ -z "${DISPLAY}" ]; then
        echo -e "${RED}[ERROR] * No DISPLAY environment variable!  Set value with:${NC}"
        echo
        echo -e "-e DISPLAY=unix\$DISPLAY"
        echo
        exit 1
    fi

    if [ -z "${XCOOKIE}" ]; then
        echo -e "${YELLOW}[WARNING] * No X11 magic cookie value supplied!"
        echo -e "            If you get an error like \"Gtk-WARNING **: cannot open display: unix:0\", try passing the X11 magic cookie with:${NC}"
        echo
        echo -e "-e XCOOKIE=\"\$(xauth list | grep unix | cut -f2 -d\"/\" | tr -cd '\11\12\15\40-\176' | sed -e 's/  / /g')\""
        echo
    else
        if [ ! -e $HOME/.Xauthority ]; then
            sudo -u $USERNAME touch $HOME/.Xauthority
        fi
        echo -e "${BLUE}Adding X11 magic cookie: ${XCOOKIE}${NC}"
        sudo -u $USERNAME xauth add $XCOOKIE
    fi

    # Verify sound settings
    echo -e "${BLUE}Checking for PulseaAudio${NC}"
    if [ -z "${PULSE_SERVER}" ] || [ ! -e $(echo $PULSE_SERVER | cut -f2 -d":") ]; then
        echo -e "${YELLOW}[WARNING] * No PulseAudio socket transfered!"
        echo -e "            If audio is not working, pass environment variable PULSE_SERVER and bind mount the socket with:${NC}"
        echo
        echo -e "-e PULSE_SERVER=unix:\$XDG_RUNTIME_DIR/pulse/native"
        echo -e "-v \$XDG_RUNTIME_DIR/pulse/native:\$XDG_RUNTIME_DIR/pulse/native:ro"
        echo
    fi

    sudo -Eu $USERNAME spotify $@

    echo -e "${BLUE}Shutting down${NC}"
}

main $@
exit $?
