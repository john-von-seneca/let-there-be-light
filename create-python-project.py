#!/usr/bin/python

import os
import sys
import errno
from subprocess import CalledProcessError, check_call
import re

HOME = os.path.expanduser('~')

def main(argv):
	dir_root = get_dir_name(argv[0])
	project_name = os.path.basename(dir_root)
	src_folder = os.path.join(dir_root, project_name)
	make_dir(src_folder)
	dir_names = ['scripts','tests','lib','doc','apidoc']
	for dir_name in dir_names:
		make_dir(os.path.join(src_folder, dir_name))
	touch(os.path.join(src_folder, 'main.py'))
	touch(os.path.join(src_folder, '__init__.py'))
	touch(os.path.join(src_folder, 'tests', '__init__.py'))
	touch(os.path.join(src_folder, 'tests', 'test_main.py'))

def touch(filename):
	if not(os.path.exists(filename)):
		print('touching %s ...' % filename)
		check_call(['touch', filename])
	else:
		print('file exists: %s ...' % filename)

def make_dir(folder):
	if not(os.path.exists(folder)):
		print('create directory %s ...' % folder)
		check_call(['mkdir', '-p', folder])
	else:
		print('folder exists: %s ...' % folder)
	
def get_dir_name(dir_name):
	re.sub('~',HOME,dir_name)
	return dir_name
	

if __name__ == "__main__":
	main(sys.argv[1:])

