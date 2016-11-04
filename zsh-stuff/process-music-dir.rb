
require 'shellwords'

test = false

def get_all_cases(elements)
	elements.map {|f| [f.upcase, f.capitalize, f]}.flatten()
end

f_cover = 'cover.jpg'
possible_cover_names = get_all_cases(%w{cover folder front})
possible_cover_exts  = get_all_cases(%w{jpeg jpg})

possible_cover_names.each do |possible_cover_name|
	break if(File.exists?(f_cover))
	possible_cover_exts.each do |possible_cover_ext|
		cover_alt = possible_cover_name + '.' + possible_cover_ext
		if(File.exists?(cover_alt))
			`mv #{cover_alt} #{f_cover}`
			break
		end
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
Dir.glob("*.{JPG,jpg,JPEG,jpeg,png,bmp}").each do |img|
	`mv #{img.shellescape} art/` unless img==f_cover
end

# other folders to meta folder
%w{Data logs}.each do |meta_src|
	if(File.directory?(meta_src))
		puts(">> mv files from #{meta_src} to meta")
		puts("\tmv #{meta_src}/* meta/")
		`mv #{meta_src}/* meta/` unless test
		puts("\trm -rf #{meta_src}")
		`rm -rf #{meta_src}` unless test
	end
end

# other folders to art folder
%w{covers Covers Cover scan Scan Scans scans Artwork artwork}.each do |art_src|
	if(File.directory?(art_src))
		puts(">> mv files from #{art_src} to art")
		`mv #{art_src}/* art/` unless test
		`rm -rf #{art_src}` unless test
	end
end

# moving files to meta
%w{log cue CUE pdf txt TXT Txt url rtf accurip cfg md5}.each do |file_ext|
	next if Dir.glob("*.#{file_ext}").empty?
	puts(">> mv #{file_ext} files ... ")
	`mv *.#{file_ext} meta/` unless test
end

# removing extraneous files
%w{m3u m3u8 pls}.each do |file_ext|
	next if Dir.glob("*.#{file_ext}").empty?
	puts(">> rm #{file_ext} files ... ")
	`rm -f *.#{file_ext}` unless test
end


