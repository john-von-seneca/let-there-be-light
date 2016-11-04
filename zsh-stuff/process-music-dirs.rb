require 'shellwords'
require_relative 'process-music-dir.rb'

prefix = ARGV[0].upcase
folders = `ls`.split("\n")
folders_match = folders.select {|folder| folder[0].upcase == prefix}
for folder in folders_match
	files = `ls ./#{folder.shellescape}`.split("\n")
	music_files = files.select {|file| ['mp3', 'flac'].include?(file.split('.')[-1])}
	puts("#{folder}: # #{music_files.size}")
	if music_files.size > 0
		ProcessMusicDir.execute(folder)
	end
end
