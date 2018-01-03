source $HOME/.private_aliases
source $HOME/.docker_aliases

export VISUAL='vim'

alias http="python -m SimpleHTTPServer 8888"
alias python='python2'
alias ipython='ipython2'
alias pip='pip2'
alias virtualenv='virtualenv2'
alias vi='vim'

alias apidep='aws apigateway create-deployment --stage-name v1 --rest-api-id'
alias tcpwatch="sudo tcpflow -p -c -i eth0 port 80 | grep -oE '(GET|POST|HEAD) .* HTTP/1.[01]|Host: .*'"
alias rs='python manage.py runserver'
alias celd='python manage.py celeryd --loglevel=INFO --autoreload'
alias celb='python manage.py celerybeat --scheduler=djcelery.schedulers.DatabaseScheduler'
alias vpn="sudo openvpn --config $HOME/openvpn_confs/adi.ovpn --auth-retry interact --max-routes 5000"
alias xsel='xsel --clipboard'
alias please='sudo $(history -p \!\!)'

function ec2list() {
    auth-aws $1
    aws --region us-east-1 --profile $AWS_DEFAULT_PROFILE ec2 describe-instances --no-paginate --query 'sort_by(Reservations[].Instances[].{IP:NetworkInterfaces[0].PrivateIpAddress, State:State.Name, Name:Tags[?Key==`Name`].Value | [0], Launched:LaunchTime}, &Name)' --output table;
}

function vt() {
    local fn=$1
    aws cloudformation validate-template --template-body file://$fn;
    /usr/bin/json_verify < $fn;
}

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
