
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
	str_out.split("\n")
end

def get_active_sink_info()
	pacmd_info = `pacmd info`.split("\n")
	ix_start = pacmd_info.find_index {|line| line.index("sink(s) available")}
	ix_end = pacmd_info.find_index {|line| line.index("source(s) available")}
	#puts("#{ix_start} ... #{ix_end} => #{ix_end-ix_start}")
	ix_active_start = pacmd_info[ix_start...ix_end].find_index {|line| line.index("* index")} + ix_start
	ix_next = pacmd_info[ix_active_start+1...ix_end].find_index{|line| line =~ /index:/}
	ix_active_end = ix_next.nil? ? ix_end : ix_active_start+1+ix_next
	pi_active = pacmd_info[ix_active_start...ix_active_end]
	#puts("#{ix_active_start} ... #{ix_active_end} => #{ix_active_end-ix_active_start} lines:: #{pi_active.size}")
	#puts(pi_active)
	
	ix_active_sink = pi_active[0].split(":").last.to_i
	#puts("ix-active: #{ix_active_sink}")
	name = pi_active.find {|line| line =~ /name/}.split(": ").last
	#puts("name: #{name}")
	state = pi_active.find {|line| line =~ /state/}.split(": ").last
	#puts("state: #{state}, ix: #{ix_active_sink}")
	volume = pi_active.find {|line| line =~ /volume/}.split(":")[2].split("%").first.to_i
	#puts("volume: #{volume}")
	{index: ix_active_sink, name: name, state: state, volume: volume}
end

def get_index(sound_cards, pattern, antipattern=nil)
	selected = sound_cards.select{|sc| sc =~ pattern}
	selected = sound_cards.reject{||} if antipattern
	selected.first.split(": ").last.split.first.to_i
end

if __FILE__ == $0
	soundcards(true)
end
