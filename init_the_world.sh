#!/bin/zsh

###ln -s $PWD/gitconfig ~/.gitconfig
###
NEODIR="$HOME/neo-human"
HOME_DIR="$NEODIR/repos/let-there-be-light"
REPOSDIR="$NEODIR/repos"
###
#### create github projects directory
###if [ -d $GITREPOS ]; then
###  echo "$GITREPOS found... not creating"
###else
###  echo "creating directory $GITREPOS ... "
###  mkdir $GITREPOS
###fi
###
#### clone myrepos into it
###GITMYREPO="$GITREPOS/myrepos"
###if [ -d $GITMYREPO ]; then
###	echo "$GITMYREPO found... not creating"
###else
###	git clone git@github.com:joeyh/myrepos.git $GITMYREPO
###fi
###
###MRLINK="/usr/local/bin/mr"
###if [ -L "$MRLINK" ]; then
###  echo "$MRLINK found... not creating symlink"
###else
###  echo "creating symlink $MRLINK ... "
###  sudo ln -s $GITMYREPO/mr $MRLINK
###  # reload the symlinks in PATH
###  rehash
###fi
###
#### symlink myrepo config in home folder
###MYREPOLINK="$HOME/.mrconfig"
###if [ -L "$MYREPOLINK" ]; then
###  echo "$MYREPOLINK found... not creating symlink"
###else
###  echo "creating symlink $MYREPOLINK ... "
###  ln -s $HOME/let-there-be-light/.mrconfig $MYREPOLINK
###fi
###
###cd $HOME
#### mr -c $HOME/let-there-be-light/.mrconfig update
###mr update




###git clone git@github.com:balasanjeevi/dot-emacs.git $HOME/.emacs.d
ln -s $REPOSDIR/dot-emacs-d/ ~/.emacs.d
~/.emacs.d/install.sh

# need to add symlinks to zshrc, zsh_functions, zsh_completions

#git clone https://github.com/zsh-users/antigen.git
LINK_ZSHRC="$HOME/.zshrc"
if [ -L "$LINK_ZSHRC" ]; then
  echo "$LINK_ZSHRC found... backing it up"
  TIME_NOW=`date +%F.%H%M`
  mv $LINK_ZSHRC $LINK_ZSHRC.bkp.$TIME_NOW
fi
echo "creating symlink $LINK_ZSHRC ... "
ln -s $HOME_LIGHT/zshrc $LINK_ZSHRC




# symlink tigrc
LINK_TIG="$HOME/.tigrc"
if [ -L "$LINK_TIG" ]; then
  echo "$LINK_TIG found... backing it up"
  TIME_NOW=`date +%F.%H%M`
  mv $LINK_TIG $LINK_TIG.bkp.$TIME_NOW
fi
echo "creating symlink $LINK_TIG ... "
ln -s $HOME_LIGHT/tigrc $LINK_TIG

# symlink conkyrc
LINK_CONKY="$HOME/.conkyrc"
if [ -L "$LINK_CONKY" ]; then
  echo "$LINK_CONKY found... backing it up"
  TIME_NOW=`date +%F.%H%M`
  mv $LINK_CONKY $LINK_CONKY.bkp.$TIME_NOW
fi
echo "creating symlink $LINK_CONKY ... "
ln -s $HOME_LIGHT/conkyrc $LINK_CONKY

# symlink weather_machi.sh
LINK_WTHR="$HOME/.weather"
if [ -L "$LINK_WTHR" ]; then
  echo "$LINK_WTHR found... backing it up"
  TIME_NOW=`date +%F.%H%M`
  mv $LINK_WTHR $LINK_WTHR.bkp.$TIME_NOW
fi
echo "creating symlink $LINK_WTHR ... "
#ln -s $HOME_LIGHT/weather_machi.sh $LINK_WTHR
ln -s $HOME_LIGHT/weather $LINK_WTHR

# symlink i3
LINK_I3DIR="$HOME/.i3"
if [ -L "$LINK_I3DIR" ]; then
  echo "$LINK_I3DIR found... backing it up"
  TIME_NOW=`date +%F.%H%M`
  mv $LINK_I3DIR $LINK_I3DIR.bkp.$TIME_NOW
fi
echo "creating symlink $LINK_I3DIR ... "
ln -s $HOME_LIGHT/.i3 $LINK_I3DIR


source $HOME/.zshrc

## ruby helpers
gc git@github.com:rbenv/rbenv.git
ln -s ~/neo-human/repos/rbenv/ ~/.rbenv

gc git@github.com:rbenv/ruby-build.git
mkdir -p ~/.rbenv/plugins/
ln -s ~/neo-human/repos/ruby-build/ ~/.rbenv/plugins/

ln -s $HOME_LIGHT/irbrc ~/.irbrc

./fstab-stuff.sh


# increase the size of apt-cache

