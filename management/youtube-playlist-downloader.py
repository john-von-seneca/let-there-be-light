import sys
import subprocess as sp
import re

# read all playlists file
def read_playlist(fn_playlist):
	f_playlist = open(fn_playlist,"r")
	lines = f_playlist.readlines()
	f_playlist.close()
	lines = [line.strip() for line in lines]
	urls = [{'name': z[0], 'url': z[1]} for z in zip(lines[::2],lines[1::2])]
	return urls

def get_parameters(dir_dstn):
	return ['--yes-playlist',
			 '--continue',
			 '--sleep-interval=5',
			 '--sub-lang=en',
			 '--write-sub',
			 '--output',
			 '' + dir_dstn + '/%(uploader)s/%(playlist_title)s/%(playlist_index)s-%(title)s.f%(format)s.%(ext)s',
			 '--no-part',
			 '--write-description',
			 '--write-annotations',
			 '--format','18']

def download(dir_dstn, urls, pattern_title=None):
	for url in urls:
		print('name:', url['name'])
		if (pattern_title is None) or (re.match('.*'+pattern_title, url['name'])):
			sp.call(['youtube-dl'] + get_parameters(dir_dstn) + [url['url']])

pattern_title = None
if(len(sys.argv)>1):
	pattern_title = sys.argv[1]
	
dir_playlist = "/media/sulley/quest/courses/youtube-playlists"
urls = read_playlist(dir_playlist + "/playlists")
download(dir_playlist, urls, pattern_title)
