


test = false

puts(">> processing cover.jpg")
`mkdir -p art; cp cover.jpg art/cover-original1.jpg; convert cover.jpg -resize 400 -quality 50 cover.jpg` unless test

puts(">> create meta dir")
`mkdir -p meta` unless test

# to meta folder
%w{Data}.each do |meta_src|
	if(File.directory?(meta_src))
		puts(">> mv files from #{meta_src} to meta")
		`mv #{meta_src}/* meta/` unless test
		`rm -rf #{meta_src}` unless test
	end
end

# to art folder
%w{scan}.each do |art_src|
	if(File.directory?(art_src))
		puts(">> mv files from #{art_src} to art")
		`mv #{art_src}/* art/` unless test
		`rm -rf #{art_src}` unless test
	end
end

# moving files to meta
%w{log cue pdf txt url}.each do |file_ext|
	puts(">> mv #{file_ext} files ... ")
	`mv *.#{file_ext} meta/` unless test
end

# removing extraneous files
%w{m3u}.each do |file_ext|
	puts(">> rm #{file_ext} files ... ")
	`rm -f *.#{file_ext}` unless test
end



