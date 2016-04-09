
load 'soundcards-info.rb'
sound_cards = soundcards().split("\n")

# if arg is not number, then it gotta be "speaker/monitor"
ix_sink_out = nil
begin
	Integer(ARGV[0])
	ix_sink_out = ARGV[0]
rescue ArgumentError => e
	case(ARGV[0])
	when "monitor"
		ix_sink_out = sound_cards.each_index.select {|ix| sound_cards[ix].index("hdmi")}.first
	when "speaker"
		ix_sink_out = sound_cards.each_index.select {|ix| sound_cards[ix].index("analog")}.first
	when "toggle"
		ix_active_soundcard = sound_cards.each_index.select {|ix_sc| sound_cards[ix_sc].index("RUNNING")}.first
		ix_other_soundcard = (ix_active_soundcard+1) % 2
		ix_sink_out = ix_other_soundcard
	else
		raise "Invalid input #{ARGV[0]}"
	end
end
raise("Invalid Input #{ARGV[0]}") if ix_sink_out.nil?

sink_inputs = `pacmd list-sink-inputs`.split("\n").select {|line| line.index("index")}
sink_inputs.each do |sink_input|
	ix_sink = sink_input.split(":").last
	puts("pacmd move-sink-input #{ix_sink} #{ix_sink_out}")
	`pacmd move-sink-input #{ix_sink} #{ix_sink_out}` 
	`pacmd set-default-sink #{ix_sink_out}` 
end

puts(soundcards())
