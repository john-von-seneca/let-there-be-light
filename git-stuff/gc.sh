cd ~/repos

echo $1
if [[ $1 == https* ]];
then
	dirgitcurr=`echo $1 | sed 's/https:\/\/github.com\/\(.*\).git/\1/'`
fi
if [[ $1 == git* ]];
then
	dirgitcurr=`echo $1 | sed 's/.*:\(.*\).git/\1/'`
fi

if [[ -z $dirgitcurr ]];
then
	echo "dirgitcurr not set"
	exit 125
fi

echo $dirgitcurr

# sed 's/https:\/\/github.com\/\(.*\).git/\1/'
git clone --depth 1 $1 ~/repos/$dirgitcurr
