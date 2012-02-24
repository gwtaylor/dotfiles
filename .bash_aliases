#!/bin/bash
# Aliases

# Quick, no-windowing emacs
#alias em="emacs -nw"
# Set monochrome term since my color-theme doesn't work over ssh
#alias em="TERM=xterm-mono emacsclient -t -a emacs"
# Solarized actually does work over SSH
# this only works for Emacs > 23
alias em="emacsclient -t -a emacs"  # open in terminal
alias ec="emacsclient -c -a emacs"  # open in window
#for killing apps
function psapp() {
    ps -ax | grep -i $1 | grep -i -v  "grep.-i.$1" | awk '{print $1}'
}
function killapp() {
    kill $(psapp $1)
}
#kills the tunnel
alias kt='killapp blowfish'

alias tunnelnyu="ssh -f -N -c blowfish gwtaylor@access1.cims.nyu.edu -L 5901:moth.cs.nyu.edu:5980"
alias tunnelbmdy="ssh -f -N -c blowfish gwtaylor@bmdy.dyndns.org -L 5900:localhost:5900"
alias tunnelbmdyoanda="ssh -f -N -c blowfish gwtaylor@bmdy.dyndns.org -L 2222:gtaylor-pc.dev.oanda.com:22"
alias sshbmdy="ssh bmdy.dyndns.org"
alias sot="ssh -p 2222 gtaylor@localhost"

# Access
alias sa='ssh gwtaylor@access.cims.nyu.edu'

# OANDA
alias so='ssh gtaylor@gtaylor-pc.dev.oanda.com'

# HPC cluster
alias sshhpc="ssh gwt2@hpc.es.its.nyu.edu"

#tunnel for matlab license
alias matlabtunnel='ssh -L 1049:hilbert.acs.its.nyu.edu:1049 -L 27000:hilbert.acs.its.nyu.edu:27000 access.cims.nyu.edu'

# Platform-specific aliases

if  [ `uname -s` == 'SunOS' ] || [ `uname -s` == 'Linux' ]  ; then

    # open up file with emacsclient; otherwise start new session
    alias ec="~/bin/EDITOR"

    # start vnc server with preferred geometry
    alias myvncserver="vncserver :80 -geometry 1680x1050"

    # newer machines should alias ssh to ssh -Y
    THIS_ARCH=`arch`
    if [ "sun4" != "$THIS_ARCH" ]; then
        if [ "$TERM" != "dumb" ]; then
            alias ssh="ssh -Y"
        fi
    fi

fi

# All architectures using new ipython
alias ipy="ipython --pylab"

# # start up elastic-mapreduce
alias emsl='elastic-mapreduce --create --alive --hive-interactive --name "$(hostname) @ $(date)" --num-instances 10 --bootstrap-action s3://elasticmapreduce/bootstrap-actions/configurations/latest/memory-intensive --bootstrap-action s3://mkschema.bi.oanda.com/scripts/hive-bootstrap-action.sh --hadoop-version 0.20 --hive-versions 0.7.1 --hive-site=s3://mkschema.bi.oanda.com/conf/hive-site.xml --hive-versions 0.7.1 --slave-instance-type m1.large --master-instance-type m1.large'
alias ems='elastic-mapreduce --create --alive --hive-interactive --name "$(hostname) @ $(date)" --num-instances 25 --bootstrap-action s3://elasticmapreduce/bootstrap-actions/configurations/latest/memory-intensive --bootstrap-action s3://mkschema.bi.oanda.com/scripts/hive-bootstrap-action.sh --hadoop-version 0.20 --hive-versions 0.7.1 --hive-site=s3://mkschema.bi.oanda.com/conf/hive-site.xml --hive-versions 0.7.1 --slave-instance-type m1.small --master-instance-type m1.small'
# # list active em clusters
alias emla='elastic-mapreduce --list --active'
# # ssh to the first cluster with status WAITING
#alias emssh="elastic-mapreduce --ssh `elastic-mapreduce | grep WAITING | head -n 1 | awk '{print $1}'`"

# start up vnc on gtaylor-pc
alias vnco='ssh -f -c blowfish gtaylor@gtaylor-pc.dev.oanda.com "killall x11vnc; x11vnc -xkb -noxdamage"'
