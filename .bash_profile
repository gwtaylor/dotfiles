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

