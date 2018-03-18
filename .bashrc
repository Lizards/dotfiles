#
# ~/.bashrc
#

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

. $HOME/dotfiles/submodules/git/contrib/completion/git-prompt.sh

bash_prompt() {
    local COLOR_NONE="\[\033[0m\]"  # unsets color to term's fg color

    # regular colors
    local COLOR_BLACK="\[\033[0;30m\]"
    local COLOR_RED="\[\033[0;31m\]"
    local COLOR_GREEN="\[\033[0;32m\]"
    local COLOR_YELLOW="\[\033[0;33m\]"
    local COLOR_BLUE="\[\033[0;34m\]"
    local COLOR_MAGENTA="\[\033[0;35m\]"
    local COLOR_CYAN="\[\033[0;36m\]"
    local COLOR_WHITE="\[\033[0;37m\]"

    # emphasized (bolded) colors
    local COLOR_BLACK_BOLD="\[\033[1;30m\]"
    local COLOR_RED_BOLD="\[\033[1;31m\]"
    local COLOR_GREEN_BOLD="\[\033[1;32m\]"
    local COLOR_YELLOW_BOLD="\[\033[1;33m\]"
    local COLOR_BLUE_BOLD="\[\033[1;34m\]"
    local COLOR_MAGENTA_BOLD="\[\033[1;35m\]"
    local COLOR_CYAN_BOLD="\[\033[1;36m\]"
    local COLOR_WHITE_BOLD="\[\033[1;37m\]"

    # background colors
    local COLOR_BLACK_BG="\[\033[40m\]"
    local COLOR_RED_BG="\[\033[41m\]"
    local COLOR_GREEN_BG="\[\033[42m\]"
    local COLOR_YELLOW_BG="\[\033[43m\]"
    local COLOR_BLUE_BG="\[\033[44m\]"
    local COLOR_MAGENTA_BG="\[\033[45m\]"
    local COLOR_CYAN_BG="\[\033[46m\]"
    local COLOR_WHITE_BG="\[\033[47m\]"

    local COLOR_GIT=$COLOR_YELLOW_BOLD
    local COLOR_USER=$COLOR_GREEN
    local COLOR_HOST=$COLOR_YELLOW
    local COLOR_PATH=$COLOR_BLUE_BOLD

    if [ "$1" = yes ]; then
        # PS1="${COLOR_GIT}\$(__git_ps1 \"(%s) \")${COLOR_USER}\u@\h${COLOR_NONE}:${COLOR_PATH}\W${COLOR_NONE}$ "
        PS1="${COLOR_GIT}\$(__git_ps1 \"(%s) \")${COLOR_USER}\u@\h${COLOR_NONE} in ${COLOR_PATH}\w${COLOR_NONE}\n$ "
    else
        PS1="\$(__git_ps1 \"(%s) \") \u@\h:\w\$ "
    fi
}
bash_prompt $color_prompt
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\$(__git_ps1 \"(%s) \")\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
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

. /usr/share/z/z.sh

source $HOME/dotfiles/submodules/git/contrib/completion/git-completion.bash

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

complete -C '$HOME/paws/bin/aws_completer' aws

export PATH=$PATH:$HOME/work/paws/bin

