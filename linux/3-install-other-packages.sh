npm install -g diff-so-fancy

# https://www.gnu.org/software/global/download.html
cd ~/neo-human/repos/gnu-src/global/
cvs update -P -d
sh reconf.sh 
./configure
make -j7
sudo make install
