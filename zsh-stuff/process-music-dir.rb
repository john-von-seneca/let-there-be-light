
require 'shellwords'

test = false

f_cover = 'cover.jpg'
%w{cover.jpeg folder.jpeg folder.jpg Folder.jpg Folder.jpeg Cover.jpg Cover.jpeg}.each do |cover_alt|
	break if(File.exists?(f_cover))
	if(File.exists?(cover_alt))
		`mv #{cover_alt} #{f_cover}`
		break
	end
end

unless(File.exists?(f_cover))
	f_folder_name = File.basename(Dir.pwd)
	f_folder_name = 'The ' + f_folder_name[0..-6] if(f_folder_name[-5..-1] == ', The')
	%w{jpg jpeg}.each do |jpg_ext|
		f_cover_name = f_folder_name + '.' + jpg_ext
		if(File.exists?(f_cover_name))
			#f_cover_name_sanitized = f_cover_name.gsub(/\'/,"\\\\'")
			#f_cover_name_sanitized = f_cover_name
			puts(">> mv \"#{f_cover_name}\" #{f_cover}")
			`mv #{f_cover_name.shellescape} #{f_cover}`
			break
		end
	end
	%w{png bmp}.each do |other_ext|
		f_cover_name = f_folder_name + '.' + other_ext
		if(File.exists?(f_cover_name))
			`convert #{f_cover_name} #{f_cover}`
			break
		end
	end
end

unless(File.exists?(f_cover))
	raise("#{f_cover} not found")
end

puts(">> processing cover.jpg")
`mkdir -p art; cp cover.jpg art/cover-original1.jpg; convert cover.jpg -resize 400 -quality 50 cover.jpg` unless test

puts(">> create meta dir")
`mkdir -p meta` unless test

# mv other images to art folder
puts('>> moving image files to art/')
Dir.glob("*.{jpg,jpeg,png,bmp}").each do |img|
	`mv #{img.shellescape} art/` unless img==f_cover
end

# other folders to meta folder
%w{Data}.each do |meta_src|
	if(File.directory?(meta_src))
		puts(">> mv files from #{meta_src} to meta")
		puts("\tmv #{meta_src}/* meta/")
		`mv #{meta_src}/* meta/` unless test
		puts("\trm -rf #{meta_src}")
		`rm -rf #{meta_src}` unless test
	end
end

# other folders to art folder
%w{Cover scan Scan Scans scans Artwork artwork}.each do |art_src|
	if(File.directory?(art_src))
		puts(">> mv files from #{art_src} to art")
		`mv #{art_src}/* art/` unless test
		`rm -rf #{art_src}` unless test
	end
end

# moving files to meta
%w{log cue pdf txt url}.each do |file_ext|
	next if Dir.glob("*.#{file_ext}").empty?
	puts(">> mv #{file_ext} files ... ")
	`mv *.#{file_ext} meta/` unless test
end

# removing extraneous files
%w{m3u m3u8}.each do |file_ext|
	next if Dir.glob("*.#{file_ext}").empty?
	puts(">> rm #{file_ext} files ... ")
	`rm -f *.#{file_ext}` unless test
end



