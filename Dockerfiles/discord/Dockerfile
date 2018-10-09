# Discord desktop app
# Discord image with xauth for X11 Magic Cookie support, Pulse Audio, socat (for xdg-open-server tool), and run as `discord` user
#
# docker build -t lizards/discord .

FROM debian:buster
LABEL maintainer "<amanda@smart.net>"

ENV HOME /home/discord
ENV DEBIAN_FRONTEND noninteractive
ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

RUN apt-get update && apt-get install -y \
    xauth \
    socat \
    alsa-utils \
    pulseaudio \
    apt-utils \
    dbus-x11 \
    dunst \
    hunspell-en-us \
    python3-dbus \
    software-properties-common \
    libx11-xcb1 \
    gconf2 \
    libgtk2.0-0 \
    libxtst6 \
    libnss3 \
    libasound2 \
    wget \
    libatomic1 \
    libnotify4 \
    libappindicator1 \
    libc++1 \
    --no-install-recommends \
    && wget "https://discordapp.com/api/download?platform=linux&format=deb" -O /tmp/discord.deb \
    && dpkg -i /tmp/discord.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd --create-home --home-dir $HOME discord \
    && mkdir -p $HOME/.config/pulse/ \
    && chown -R discord:discord $HOME \
    && usermod -a -G audio,video discord

WORKDIR $HOME
USER discord

ENTRYPOINT ["discord"]
CMD []
