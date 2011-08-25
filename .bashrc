DOTFILES_DIR=~/dotfiles

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Custom prompt
PS1='\h:\W \u\$ '

# Change the window title of X terminals 
case $TERM in
	xterm*|rxvt*|Eterm)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac


# Platform-specific statements
if [ `uname -s` == 'Darwin' ] && [ -f ${DOTFILES_DIR}/.bashrc.Darwin ]; then
    . ${DOTFILES_DIR}/.bashrc.Darwin
fi

if  [ `uname -s` == 'SunOS' ] || [ `uname -s` == 'Linux' ]  && [ -f ${DOTFILES_DIR}/.bashrc.Linux ]; then
    . ${DOTFILES_DIR}/.bashrc.Linux
fi

# custom aliases
if [ -f ${DOTFILES_DIR}/.bash_aliases ]; then
    . ${DOTFILES_DIR}/.bash_aliases
fi