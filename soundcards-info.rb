
def soundcards(b_print=false)
	pacmd_info = `pacmd info`.split("\n")
	#puts(pacmd_info.size)

	ix_sinks_available = pacmd_info.find_index {|line| line.index("sink(s) available")}
	ix_src_available = pacmd_info.find_index {|line| line.index("source(s) available")}

	ixs_index = pacmd_info[ix_sinks_available...ix_src_available].each_index.select do |ix|
		pacmd_info[ix_sinks_available+ix].index("index")
	end
	str_out = ""
	ixs_index.each do |ix_index|
		#puts("## #{pacmd_info[ix_sinks_available+ix_index..ix_sinks_available+ix_index+1]}")
		str_out +=  pacmd_info[ix_sinks_available+ix_index] + "\t"
		str_out += " " + pacmd_info[ix_sinks_available+ix_index+4].split(": ").last
		str_out += " " + pacmd_info[ix_sinks_available+ix_index+1].split(": ").last
		str_out += "\n"
	end
	puts(str_out) if b_print
	str_out
end

if __FILE__ == $0
   soundcards(true)
end
