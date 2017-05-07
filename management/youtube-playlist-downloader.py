import os
import re
import subprocess as sp
import sys

# read all playlists file
def read_playlist(fn_playlist):
	f_playlist = open(fn_playlist,"r")
	lines = f_playlist.readlines()
	f_playlist.close()
	lines = [line.strip() for line in lines]
	urls = [{'name': z[0], 'url': z[1]} for z in zip(lines[::2],lines[1::2])]
	return urls

def get_parameters():
	return [ '--continue',
			 '--sleep-interval=5',
			 '--sub-lang=en',
			 # '--write-sub',
			 '--no-part',
			 # '--write-description',
			 # '--write-annotations',
			 # '--external-downloader',
			 # 'axel',
			 # '--external-downloader-args',
			 # '--alternate --num-connections=3'
			 # ' --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20150101 Firefox/47.0 (Chrome)"',
			 '--format','18']

def get_parameters_playlist(dir_dstn):
	pmtrs = get_parameters()
	pmtrs.append('--yes-playlist')
	pmtrs.append('--output')
	pmtrs.append('' + dir_dstn + '/%(uploader)s/%(playlist_title)s/%(playlist_index)s-%(title)s.f%(format)s.%(ext)s')
	return pmtrs

def get_parameters_file(dir_dstn):
	pmtrs = get_parameters()
	pmtrs.append('--output')
	pmtrs.append('' + dir_dstn + '/%(title)s.f%(format)s.%(ext)s')
	return pmtrs

def download_from_file():
	assert(len(sys.argv)>=2)
	file_name = sys.argv[2]
	urls = [line.strip() for line in open(file_name).readlines()]
	pmtrs = get_parameters_file(os.path.dirname(file_name))
	for url in urls:
		print('url:', url)
		sp.call(['youtube-dl'] + pmtrs  + [url])

	
def download_from_playlist():
	assert(len(sys.argv)>=2)
	dir_playlist = sys.argv[2]
	pattern_title = ''
	if(len(sys.argv)>3):
		pattern_title = sys.argv[3]
	print(pattern_title)
	urls = read_playlist(dir_playlist + "/playlists")
	patterns = [pattern.strip() for pattern in pattern_title.split(",") if pattern is not None]
	pmtrs = get_parameters_playlist(dir_playlist)
	for pattern in patterns:
		for url in urls:
			print('name:', url['name'])
			if (pattern is None) or (re.match('.*'+pattern, url['name'])):
				sp.call(['youtube-dl'] + pmtrs + [url['url']])

		
dwld_type = 'file'
if(len(sys.argv)>1):
	dwld_type = sys.argv[1]
	
if(dwld_type=='file'):
	download_from_file()
elif(dwld_type=='playlist'):
	download_from_playlist()



