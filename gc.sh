cd ~/neo-human/repos
dirgitcurr=`echo $1 | sed 's/.*:\(.*\).git/\1/'`
git clone $1 $dirgitcurr
