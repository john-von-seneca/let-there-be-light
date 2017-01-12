load 'soundcards-info.rb'
sound_cards = soundcards()

active_sink = get_active_sink_info()

case(ARGV[0])
when "+"
	vol = [65536, ((active_sink[:volume] + 10)/100.0) * 65535].min
when "-"
	vol = [0, ((active_sink[:volume] - 10)/100.0) * 65536].max
else
	raise("what the fuck is this #{ARGV[0]}")
end
vol = vol.to_i
puts("#{active_sink[:index]} #{active_sink[:volume]} -> #{vol}")
`pacmd set-sink-volume #{active_sink[:index]} #{vol}`
puts(get_active_sink_info())
puts("#{active_sink[:index]} #{vol}")
