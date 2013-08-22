DOTFILES_DIR=~/dotfiles

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$HOME/bin:/usr/local/bin:$PATH

#Point to my subversion repository
SVN_PATH=svn+ssh://gwtaylor@access.cims/home/gwtaylor/Projects/Research
export SVN_PATH
#non research-related SVN
SVN_BASE=svn+ssh://gwtaylor@access.cims/home/gwtaylor/Projects
export SVN_BASE
SVN_PUBLIC=svn+ssh://gwtaylor@cluster30.ais.sandbox/gobi1/gwtaylor/public/svnrepo
export SVN_PUBLIC

#Disable flow control so ctrl-s actually does forward search
#See: http://ruslanspivak.com/2010/11/25/bash-history-incremental-search-forward/
stty -ixon

# Platform-specific statements
if [ `uname -s` == 'Darwin' ] && [ -f ${DOTFILES_DIR}/.bash_profile.Darwin ]; then
    . ${DOTFILES_DIR}/.bash_profile.Darwin
fi

if  [ `uname -s` == 'SunOS' ] || [ `uname -s` == 'Linux' ]  && [ -f ${DOTFILES_DIR}/.bash_profile.Linux ]; then
    . ${DOTFILES_DIR}/.bash_profile.Linux
fi

# Development joblib
export PYTHONPATH=${HOME}/src/joblib:${PYTHONPATH}

# Development milk
export PYTHONPATH=${HOME}/src/milk:${PYTHONPATH}
export PYTHONPATH=${HOME}/src/milksets:${PYTHONPATH}

# Quant stuff
# export PYTHONPATH=${HOME}/python/quant-dev:${PYTHONPATH}

# Git PyTables (bug fix for inheritance)
export PYTHONPATH=${HOME}/src/PyTables:${PYTHONPATH}

# BI python
#export PYTHONPATH=${HOME}/python/client-predictor/src/main/python:${PYTHONPATH}

# Set up virtualenv wrapper
VEBIN=`which virtualenv`
if [[ -n $VEBIN ]]; then
    VEPATH=`dirname $VEBIN`  # may be different on different platforms
    export WORKON_HOME=$HOME/virtualenvs
    source $VEPATH/virtualenvwrapper.sh
fi

# skdata data location (not backed up)
export SKDATA_ROOT=/data1/skdata