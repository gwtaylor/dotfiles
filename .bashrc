DOTFILES_DIR=~/dotfiles

if [ `uname -s` == 'Darwin' ] && [ -f ${DOTFILES_DIR}/.bashrc.Darwin ]; then
    . ${DOTFILES_DIR}/.bashrc.Darwin
fi

if  [ `uname -s` == 'SunOS' ] || [ `uname -s` == 'Linux' ]  && [ -f ${DOTFILES_DIR}/.bashrc.Linux ]; then
    . ${DOTFILES_DIR}/.bashrc.Linux
fi

