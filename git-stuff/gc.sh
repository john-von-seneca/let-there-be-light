cd ~/repos
dirgitcurr=`echo $1 | sed 's/.*:\(.*\).git/\1/'`
git clone --depth 1 $1 $dirgitcurr
