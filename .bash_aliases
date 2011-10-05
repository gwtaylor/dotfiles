#!/bin/bash
# Aliases

# Quick, no-windowing emacs
alias em="emacs -nw"

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
alias ipython="ipython --pylab"

# start up elastic-mapreduce
alias ems='elastic-mapreduce --create --alive --hive-interactive --name "$(hostname) @ $(date)" --num-instances 10 --bootstrap-action s3://elasticmapreduce/bootstrap-actions/configurations/latest/memory-intensive --bootstrap-action s3://mkschema.bi.oanda.com/scripts/hive-bootstrap-action.sh --hadoop-version 0.20 --hive-versions 0.7.1 --hive-site=s3://mkschema.bi.oanda.com/conf/hive-site.xml --hive-versions 0.7.1 --slave-instance-type m1.large --master-instance-type m1.large'

