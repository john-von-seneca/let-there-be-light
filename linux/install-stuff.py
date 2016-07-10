import sys
from subprocess import call as sp_call
import os
import subprocess as sp
import time
import tqdm


with open('./linux/ubuntu-packages','r') as f:
	packages = f.readlines()

def change_dir(work):
	if (work == "download"):
		dir1="/media/sulley/var/cache/apt/archives"
		os.chdir(dir1)
def get_options(work):
	if(work=="download"):
		return ["download"]
	elif(work=="install"):
		return ["-y", "install","--allow-unauthenticated"]
	else:
		print("wrong work: ", work)
		1/0

def do_work(work, pkgs):
	change_dir(work)
	options = get_options(work)
	if len(pkgs)==0:
		return
	pkgs = [pkg.strip() for pkg in pkgs if pkg[0]!="#"]
	print("installing ", pkgs)
	sp.call(["sudo", "apt-fast"] + options + pkgs)




work = sys.argv[1]
batch_size = 10
packages = list(set(packages))
total_size = len(packages)


#read apt-add
apt_adds = open('./linux/apt-adds','r').readlines()
apt_adds_f = [apt_add.strip() for apt_add in apt_adds if apt_add[0] != "#" and apt_add[0] != "\n"]
print(apt_adds_f)

# for apt_add in apt_adds_f:
#	sp.call(["sudo", "apt-add-repository", apt_add])

# sp.call(["sudo","apt-get","update"])

#for pkgs in packages:
for ix in tqdm.tqdm(range(total_size//batch_size)):
	pkgs = packages[ix*batch_size:(ix+1)*batch_size]
	do_work(work, pkgs)



