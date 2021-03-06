# workspace 1
# clementine
i3-msg 'workspace 1; append_layout ~/.i3/workspace-1.json'
clementine &

#sleep 40
sleep 5

# workspace 2
# clementine
i3-msg 'workspace 2; append_layout ~/.i3/workspace-2.json'
google-chrome-unstable &

#sleep 40
sleep 5

# workspace 4
# emacs + terminal
i3-msg 'workspace 4; append_layout ~/.i3/workspace-4.json'
emacs &
gnome-terminal --title=foremacs &

#sleep 40
sleep 5

# workspace 5
# terminal
i3-msg 'workspace 6; exec gnome-terminal'

# workspace 6
# nautilus
i3-msg 'workspace 0; append_layout ~/.i3/workspace-6.json'

# workspace 9
# nautilus -- desktop window
# i3-msg 'workspace 9; append_layout ~/.i3/workspace-9.json'
nautilus &



i3-msg 'workspace 7'

sleep 5

# other bgnd apps
syncthing &

sleep 15

variety &

sleep 15

# jupyter notebook --no-browser --notebook-dir=~/neo-human/programs/vanity-fair/scribbles --port=8888 --ip=0.0.0.0 &
