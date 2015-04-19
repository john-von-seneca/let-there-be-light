#!/bin/zsh

# create github projects directory
GITREPOS="$HOME/git-repos"
if [ -d $GITREPOS ]; then
  echo "$GITREPOS found... not creating"
else
  echo "creating directory $GITREPOS ... "
  mkdir $GITREPOS
fi

# clone myrepos into it
GITMYREPO="$GITREPOS/myrepos"
if [ -d $GITMYREPO ]; then
	echo "$GITMYREPO found... not creating"
else
	git clone git@github.com:joeyh/myrepos.git $GITMYREPO
fi

MRLINK="/usr/local/bin/mr"
if [ -L "$MRLINK" ]; then
  echo "$MRLINK found... not creating symlink"
else
  echo "creating symlink $MRLINK ... "
  sudo ln -s $GITMYREPO/mr $MRLINK
  # reload the symlinks in PATH
  rehash
fi

# symlink myrepo config in home folder
MYREPOLINK="$HOME/.mrconfig"
if [ -L "$MYREPOLINK" ]; then
  echo "$MYREPOLINK found... not creating symlink"
else
  echo "creating symlink $MYREPOLINK ... "
  ln -s $HOME/let-there-be-light/.mrconfig $MYREPOLINK
fi

cd $HOME
# mr -c $HOME/let-there-be-light/.mrconfig update
mr update

git clone git@github.com:balasanjeevi/dot-emacs.git $HOME/.emacs.d
$HOME/.emacs.d/install.sh








