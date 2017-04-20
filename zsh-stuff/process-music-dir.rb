
require 'shellwords'



class ProcessMusicDir
	attr_accessor :dir_root, :dir_name, :f_cover, :f_cover_full, :test
	def initialize(dir_root, dir_name, f_cover)
		@test = false
		@dir_root = dir_root
		@dir_name = dir_name
		@f_cover = f_cover
		@f_cover_full = "#{@dir_name}/#{@f_cover}"
	end
	
	def get_all_cases(elements)
		elements.map {|f| [f.upcase, f.capitalize, f]}.flatten()
	end

	def process_possible_covers(f_cover, possible_cover_names, possible_cover_exts)
		possible_cover_names.each do |possible_cover_name|
			break if(File.exists?(f_cover))
			possible_cover_exts.each do |possible_cover_ext|
				cover_alt = possible_cover_name + '.' + possible_cover_ext
				if(File.exists?(cover_alt))
					cvr_src = "#{@dir_name}/#{cover_alt}".shellescape
					cvr_dst = "#{@dir_name}/#{f_cover}".shellescape
					`mv #{cvr_src} #{cvr_dst}`
					break
				end
			end
		end
	end

	def process_from_folder_name
		return if File.exists?(@f_cover_full)
		puts("dir_name: #{@dir_name}")
		f_folder_name = File.basename((@dir_name == '.' ? File.basename(@dir_root) : @dir_name))
		f_folder_name = 'The ' + f_folder_name[0..-6] if(f_folder_name[-5..-1] == ', The')
		puts("f_folder_name: #{f_folder_name}")
		%w{jpg jpeg JPG JPEG png PNG}.each do |jpg_ext|
			f_cover_name = f_folder_name + '.' + jpg_ext
			f_cover_name_full = "#{@dir_name}/#{f_cover_name}"
			puts("#{f_cover_full} #{File.exists?(f_cover_full)}")
			if(File.exists?(f_cover_name_full))
				#f_cover_name_sanitized = f_cover_name.gsub(/\'/,"\\\\'")
				#f_cover_name_sanitized = f_cover_name
				puts(">> mv \"#{f_cover_name_full}\" #{f_cover}")
				`mv #{f_cover_name_full.shellescape} #{@f_cover_full.shellescape}`
				break
			end
		end
		
		%w{png bmp}.each do |other_ext|
			f_cover_name = f_folder_name + '.' + other_ext
			f_cover_name_full = "#{@dir_name}/#{f_cover_name}".shellescape
			if(File.exists?(f_cover_name_full))
				cvr_dst = "#{@dir_name}/#{f_cover}".shellescape
				`convert #{f_cover_name_full} #{cvr_dst}`
				break
			end
		end
	end

	def resize_cover
		puts(">> processing cover.jpg")
		art_folder = "#{@dir_name}/art"
		`mkdir -p #{art_folder.shellescape}`
		cover_info = `file #{@f_cover_full.shellescape}`
		resolution = cover_info.scan(/[0-9][0-9]+x[0-9]+/)
		please_convert = true
		resolutions = []
		if resolution
			resolutions = resolution[-1].split('x').map(&:to_i)
			min_res = resolutions.min
			please_convert = (min_res > 400)
		end
		if please_convert
			puts("resizing cover.jpg ... #{resolutions}")
			cvr_dst = "#{@dir_name}/art/cover-original1.jpg"
			`cp #{@f_cover_full.shellescape} #{cvr_dst.shellescape}; convert #{@f_cover_full.shellescape} -resize 400 -quality 50 #{@f_cover_full.shellescape}` unless test
		else
			puts("not processing cover.jpg ... #{resolutions}")
		end
	end

	def create_meta_dir
		puts(">> create meta dir")
		f_meta_full = "#{@dir_name}/meta".shellescape
		`mkdir -p #{f_meta_full}` unless test
	end

	def move_images
		# mv other images to art folder
		puts('>> moving image files to art/')
		Dir.glob("#{@dir_name.shellescape}/*.{JPG,jpg,JPEG,jpeg,png,bmp}").each do |img|
			`mv #{img.shellescape} #{@dir_name.shellescape}/art/` unless img==@f_cover_full
		end
	end

	def shell_dst(dst)
		@dir_name == '.' ? dst : "#{@dir_name}/#{dst}".shellescape
	end

	def move_other_meta_folder_contents
		%w{Data logs Technical}.each do |meta_src|
			if(File.directory?(shell_dst(meta_src)))
				puts(">> mv files from #{shell_dst(meta_src)} to #{@dir_name}/meta")
				puts("\tmv #{shell_dst(meta_src)}/* #{shell_dst('meta')}/")
				`mv #{shell_dst(meta_src)}/* #{shell_dst('meta')}/` unless test
				puts("\trm -rf #{meta_src}")
				`rm -rf #{shell_dst(meta_src)}` unless test
			end
		end
	end

	def move_other_image_folder_contents
		%w{Art covers Covers Cover scan SCAN Scan Scans scans Artwork artwork}.each do |art_src|
			art_src_full = shell_dst(art_src)
			if(File.directory?(art_src_full))
				puts(">> mv files from #{art_src_full} to art")
				`mv #{art_src_full}/* #{shell_dst('art')}/` unless test
				`rm -rf #{art_src_full}` unless test
			end
		end
	end

	def move_meta_files
		%w{sfv log LOG cue CUE pdf txt TXT Txt url rtf accurip cfg md5 nfo doc}.each do |file_ext|
			next if Dir.glob("#{@dir_name.shellescape}/*.#{file_ext}").empty?
			puts(">> mv #{@dir_name.shellescape}/*.#{file_ext} files ... ")
			`mv #{@dir_name.shellescape}/*.#{file_ext} #{shell_dst('meta')}/` unless test
		end
	end

	def remove_extraneous_files
		%w{m3u m3u8 pls ini db}.each do |file_ext|
			next if Dir.glob("#{@dir_name.shellescape}/*.#{file_ext}").empty?
			puts(">> rm #{@dir_name.shellescape}/*.#{file_ext} files ... ")
			`rm -f #{@dir_name.shellescape}/*.#{file_ext}` unless test
		end
	end

	def process
		possible_cover_names = get_all_cases(%w{cover folder front})
		possible_cover_exts  = get_all_cases(%w{jpeg jpg})

		process_possible_covers(f_cover, possible_cover_names, possible_cover_exts)
		process_from_folder_name()

		unless(File.exists?(@f_cover_full))
			raise("#{f_cover_full} not found")
		end

		resize_cover()
		create_meta_dir()
		move_images()
		move_other_meta_folder_contents()
		move_other_image_folder_contents()
		move_meta_files()
		remove_extraneous_files()
	end

	def self.execute(folder=nil)
		if folder.nil?
			dir_root, dir_name = Dir.pwd, '.'
		else
			dir_root = folder
			dir_name = File.basename(dir_root)
		end
		
		f_cover = 'cover.jpg'
		pmd = ProcessMusicDir.new(dir_root, dir_name, f_cover)
		pmd.process
	end
end


if __FILE__ == $0
	ProcessMusicDir.execute()
end
