#!/usr/env sh

INSTALLDIR=${INSTALLDIR:-"$PWD/sbvim"}
create_symlinks () {
    if [ ! -f ~/.vim ]; then
        echo "Now, we will create ~/.vim and ~/.vimrc files to configure Vim."
        ln -sfn $INSTALLDIR ~/.vim
    fi

    if [ ! -f ~/.vimrc ]; then
        ln -sfn $INSTALLDIR/vimrc ~/.vimrc
    fi
  }

echo "Welcome!"

which git > /dev/null
if [ "$?" != "0" ]; then
  echo "git is missing, aborting.."
  exit 1
fi

which vim > /dev/null
if [ "$?" != "0" ]; then
  echo "vim is missing, aborting."
  exit 1
fi

if [ ! -d "$INSTALLDIR" ]; then
    echo "As we can't find sbvim in the current directory, we will create it."
    git clone https://github.com/sbarghi/vim.git $INSTALLDIR
    create_symlinks
    cd $INSTALLDIR

else
    echo "Seems like you already installed vim settinsg, just updating."
    cd $INSTALLDIR
    git pull origin master
    create_symlinks
fi


echo "Installation is complete, run vim to install plugged."
echo "Use :PlugInstall to install plugins"
echo "Enjoy!"


