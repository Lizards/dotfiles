bash_prompt() {
    . /usr/local/lib/bash_colors.sh
    echo "${COLOR_RED}[${COLOR_NONE}\\w${COLOR_RED}]#${COLOR_NONE} "
}
# Use a subshell so color vars aren't exported to environment
PS1=$(bash_prompt)

if [ -x /usr/bin/dircolors ]; then
    # shellcheck disable=SC2015
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ll='ls -alF'

alias vi='vim'
