load 'soundcards-info.rb'
print((get_active_sink_info()[:volume]*1000).to_s)
