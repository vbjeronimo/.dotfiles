#!/bin/bash

# I'm using this autostart script to ensure that 'feh' doesn't load the
# wallpaper BEFORE 'autorandr' has finished setting up the xrandr settings

autorandr --change
nm-applet &
feh --bg-fill "$HOME/pictures/wallpapers/active"
