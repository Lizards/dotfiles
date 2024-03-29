#!/bin/bash
# Suppress single quote warning:
# shellcheck disable=SC2016
# Don't follow includes:
# shellcheck source=/dev/null

if [ -e "${HOME}/.private_aliases" ]; then
    . "${HOME}/.private_aliases"
fi
. "${HOME}/.docker_aliases"

export KUBE_EDITOR="${VISUAL}"
alias http="python -m http.server 8888"
alias vi='vim'
alias diff='diff --color=auto'
alias tcpwatch="sudo tcpflow -p -c -i eth0 port 80 | grep -oE '(GET|POST|HEAD) .* HTTP/1.[01]|Host: .*'"
alias pycleanup='find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf'
alias xsel='xsel --clipboard'
alias please='sudo $(history -p \!\!)'
alias back='cd $OLDPWD'
alias owns='pacman -Qo'
alias trackpadfix='sudo modprobe -r psmouse && sudo modprobe psmouse'
alias makepkg-sha256sums='makepkg -g -f -p PKGBUILD'
alias aur-prep="makepkg-sha256sums && makepkg --printsrcinfo > .SRCINFO"
alias fonts='fc-list | cut -f2 -d: | sort -u'

function deps {
    pacman -Qi "${1}" | grep Required
}

function aur-remove() {
    local package=$1
    repo-remove /var/cache/pacman/custom/custom.db.tar "${package}"
    sudo pacman -R "${package}"
    paccache -r
}

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

function pretty_csv() {
    perl -pe 's/((?<=,)|(?<=^)),/ ,/g;' "$@" | column -t -s, | less  -F -S -X -K
}
