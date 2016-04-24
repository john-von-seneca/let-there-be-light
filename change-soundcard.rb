
load 'soundcards-info.rb'
sound_cards = soundcards()

# if arg is not number, then it gotta be "speaker/monitor"
ix_sink_out = nil
begin
	Integer(ARGV[0])
	ix_sink_out = ARGV[0]
rescue ArgumentError => e
	case(ARGV[0])
	when "monitor"
		ix_sink_out = get_index(sound_cards, /hdmi/)
	when "speaker"
		ix_sink_out = get_index(sound_cards, /analog/, /DAC/)
	when "dac"
		ix_sink_out = get_index(sound_cards, /DAC/)
	when "cycle"
		ix_active_soundcard = get_index(sound_cards, /RUNNING/)
		ix_other_soundcard = (ix_active_soundcard+1) % sound_cards.size
		ix_sink_out = ix_other_soundcard
	else
		raise "Invalid input #{ARGV[0]}"
	end
end
raise("Invalid Input #{ARGV[0]}") if ix_sink_out.nil?
puts("ix sink out: #{ix_sink_out}")

sink_inputs = `pacmd list-sink-inputs`.split("\n").select {|line| line.index("index")}
sink_inputs.each do |sink_input|
	ix_sink = sink_input.split(":").last
	puts("pacmd move-sink-input #{ix_sink} #{ix_sink_out}")
	`pacmd move-sink-input #{ix_sink} #{ix_sink_out}` 
	`pacmd set-default-sink #{ix_sink_out}` 
end

puts(soundcards())
