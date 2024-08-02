#!/bin/bash
#
# ~/.bashrc
#
# Ignore unused variables:
# shellcheck disable=SC2034
# Don't follow includes:
# shellcheck source=/dev/null

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
color_prompt=yes
else
color_prompt=
fi

. "${HOME}/.submodules/git/contrib/completion/git-prompt.sh"

bash_prompt() {
    . /usr/local/lib/bash_colors.sh
    local COLOR_GIT=$COLOR_YELLOW_BOLD
    local COLOR_USER=$COLOR_GREEN
    local COLOR_HOST=$COLOR_YELLOW
    local COLOR_PATH=$COLOR_BLUE_BOLD
    local COLOR_PROMPT=${COLOR_GREEN}

    if [ "$1" = yes ]; then
        # shellcheck disable=SC2028
        echo "${COLOR_GIT}\$(__git_ps1 \"(%s) \")${COLOR_USER}\\u@\\h${COLOR_NONE} in ${COLOR_PATH}\\w${COLOR_NONE}\\n${COLOR_PROMPT}\$${COLOR_NONE} "
    else
        echo "\$(__git_ps1 \"(%s) \") \\u@\\h:\\w\$ "
    fi
}
PS1=$(bash_prompt "${color_prompt}")
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\\[\\e]0;\$(__git_ps1 \"(%s) \")\\u@\\h: \\w\\a\\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    # shellcheck disable=SC2015
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

. "${HOME}/.submodules/z/z.sh"

. "${HOME}/.submodules/git/contrib/completion/git-completion.bash"

eval "$(thefuck --alias)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
