


test = false

puts(">> processing cover.jpg")
`mkdir -p art; cp cover.jpg art/cover-original1.jpg; convert cover.jpg -resize 400 -quality 50 cover.jpg` unless test

puts(">> create meta dir")
`mkdir -p meta` unless test

puts(">> mv files from Data to meta")
if(File.directory?('Data'))
	`mv Data/* meta/` unless test
	`rm -rf Data` unless test
end

if(File.directory?('scan'))
	puts(">> mv files from scan to art")
	`mv scan/* art/` unless test
	`rm -rf scan` unless test
end


# moving files to meta
%w{log cue pdf txt url}.each do |file_ext|
	puts(">> mv #{file_ext} files ... ")
	`mv *#{file_ext} meta/` unless test
end

puts(">> rm playlist files ... ")
`rm -f *m3u` unless test


