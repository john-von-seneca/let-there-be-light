import sys
from subprocess import call as sp_call
import os
import subprocess as sp
import time
import tqdm

packages = [["automake", "axel"],
 ["build-essential"], 
 ["clang", "clementine", "clementine", "cmake", "cmake-curses-gui", "cmake-curses-gui", "conky-all", "cowsay", "cscope", "cscope", "cuetools", "curl"],
 ["doxygen", "doxygen", "doxygen-gui", "doxygen-gui"],
 ["easytag", "emacs", "emacs-snapshot", "emacs-snapshot-el", "exfat-fuse", "exfat-fuse", "exfat-utils", "exfat-utils"], 
 ["feh", "firefox", "fortune-mod", "freeglut3", "fslint"],
 ["g++", "gcc", "gedit", "git", "git-core", "global", "gnome-terminal", "gparted", "gradle", "grsync"],
 ["hddtemp", "hddtemp", "htop", "htop"],
 ["i3", "i3-wm", "i3-wm", "i3status", "ipython-notebook", "ipython-notebook", "ipython-notebook", "ipython-notebook", "ipython3", "ipython3", "ipython3-notebook", "ipython3-notebook"],
 ["jabref", "jabref", "jabref"],
 ["kcachegrind", "kdelibs5-data", "kdelibs5-data", "kdelibs5-plugins", "kdelibs5-plugins", "krusader"],
 ["libavcodec-dev", "libavformat-dev", "libboost-all-dev", "libdc1394-22-dev", "libeigen3-dev", "libfreetype6-dev", "libgtk2.0-dev"],
 ["libjasper-dev", "libjpeg-dev", "libpcre3", "libpython2.7", "libpython2.7", "libpython2.7-dev", "libpython2.7-dev", "libpython2.7-stdlib", "libpython2.7-stdlib", "libqt4-opengl", "libqt4-opengl", "libqt4-opengl", "libqt4-opengl-dev", "libqt4-opengl-dev", "libqt5opengl5-dev", "libreadline-dev", "libswscale-dev", "libtbb-dev", "libtbb2", "libzmq3-dev"],
 ["lm-sensors"].
 ["lfm","mc"],
 ["neovim", "nmap", "ntp", "ntp"],
 ["okular", "okular", "okular", "okular", "okular-extra-backends", "okular-extra-backends"],
 ["pdmenu", "pkg-config", "psensor", "psensor", "python-pip", "python2.7", "python3-dev", "python3-dev"], 
 ["ranger", "rbenv", "ruby"], 
 ["shellex", "silversearcher-ag", "silversearcher-ag", "silversearcher-ag", "smplayer", "sshfs", "sshfs", "stack", "suckless-tools"],
 ["tig"],
 ["valgrind", "variety", "vim-gtk", "vim-rails", "vlc"],
 ["xclip", "xkeycaps", "xkeycaps"], 
 ["zeal", "zsh"],
 ["mysql-server mysql-client libmysqlclient-dev libsqlite3-dev"],
 ['spotify-client', 'spotify-client-qt', 'terminator',
  'synapse', 'banshee',
    'banshee-extension-albumartwriter',
    'banshee-extension-ampache',
    'banshee-extension-awn',
    'banshee-extension-coverwallpaper',
    'banshee-extension-foldersync',
    'banshee-extension-lyrics',
    'banshee-extension-duplicatesongdetector',
    'banshee-extension-lcd',
    'deluge',
    'deluge-console',
    'deluge-gtk',
    'deluge-torrent',
    'deluge-web',
    'deluge-webui'],
			['libiomp-dev','binutils-dev'],
			['mercurial','subversion'],
			['virtualbox-qt','powermanagement-interface'],
			['r-base','r-base-dev', 'libeigen3-dev','python3-dev'],
			['spotify-client','spotify-client-qt', 'kodi', 'mpv', ''],
			['libcurl5-gnutls-dev','libxml2-dev','libssl-dev','libreadline-dev', 'nodejs', 'libsqlite3-dev'],
			['sublime-text-installer','pavucontrol','alsa-tools-gui','fslint','mc','lfm','aptitude','vnstat'],
 ]

def change_dir(work):
    if (work == "download"):
        dir1="/media/sulley/var/cache/apt/archives"
        os.chdir(dir1)
def get_options(work):
    if(work=="download"):
        return ["download"]
    elif(work=="install"):
        return ["-y", "install"]
    else:
        print("wrong work: ", work)
        1/0

def do_work(work, pkgs):
    change_dir(work)
    options = get_options(work)
    sp.call(["sudo", "apt-fast"] + options + pkgs)

work = sys.argv[1]
   #for pkgs in packages:
for ix in tqdm.tqdm(range(len(packages))):
    pkgs = packages[ix]
    do_work(work, pkgs)



