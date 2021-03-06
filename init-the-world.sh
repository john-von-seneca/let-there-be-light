#!/bin/zsh

###ln -s $PWD/gitconfig ~/.gitconfig
###
NEO_DIR="$HOME/neo-human"
VF_DIR="$NEO_DIR/programs/vanity-fair"
LIGHT_DIR="$VF_DIR/let-there-be-light"


# args: (<original file relative to this dir>, <link file> )
LinkFile () {
	echo "LinkFile called with args: $1, $2"
	LINK_SRC=$1
	LINK_DST=$2
	if [ -L "$LINK_DST" ]; then
		echo "$LINK_DST found... backing it up"
		TIME_NOW=`date +%F.%H%M`
		mv $LINK_DST $LINK_DST.bkp.$TIME_NOW
	fi
	echo "creating symlink $LINK_DST ... "
	/usr/local/opt/coreutils/libexec/gnubin/ln -sr $LINK_SRC $LINK_DST
}


#./fstab-stuff.sh
# increase the size of apt-cache

echo "hi"

touch ~/.zshrc_local

LinkFile zsh-stuff/zshrc ~/.zshrc
LinkFile Xmodmap ~/.Xmodmap 

LinkFile ../dot-emacs-d ~/.emacs.d
if [ "$1" = "only-link" ]; then
	echo 'skipping emacs install'
else
	~/.emacs.d/install.sh
fi;


LinkFile git-stuff/gitconfig ~/.gitconfig
LinkFile git-stuff/tigrc ~/.tigrc

LinkFile slate-config ~/.slate

LinkFile weather ~/.weather
LinkFile conkyrc ~/.conkyrc

LinkFile i3 ~/.i3

LinkFile r-stuff/Renviron ~/.Renviron

LinkFile ~/neo-human/repos/rbenv/ ~/.rbenv

if [ "$1" = "only-link" ]; then
	echo 'skipping ruby build'
else
	gc git@github.com:rbenv/ruby-build.git
	mkdir -p ~/.rbenv/plugins/
	ln -s ~/neo-human/repos/ruby-build/ ~/.rbenv/plugins/
fi;

LinkFile $LIGHT_DIR/ruby-stuff/irbrc ~/.irbrc

LinkFile haskell-stuff/stack ~/.stack

if [ "$1" = "only-link" ]; then
	echo 'skipping install-rails'
else
	ruby-stuff/install-rails
fi;

# vim stuff
LinkFile vim-stuff/vim $HOME/.vim
LinkFile vim-stuff/vimrc $HOME/.vimrc

# mathjax
LinkFile ~/repos/MathJax ~/.local/lib/python3.5/site-packages/notebook/static/components
