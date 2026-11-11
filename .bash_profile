#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# if [[ -z $DISPLAY ]] && [[ $XDG_VTNR -eq 1 ]]; then
#     exec start-hyprland || exit
# fi

if [[ -z $DISPLAY ]] && [[ $XDG_VTNR -eq 1 ]]; then
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=Hyprland
    exec dbus-run-session start-hyprland || exit
fi

echo "Running .bash_profile on VT $XDG_VTNR, DISPLAY=$DISPLAY" >> /tmp/hyprland-start.log
echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" >> /tmp/hyprland-start.log

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/dj/.lmstudio/bin"
# End of LM Studio CLI section

