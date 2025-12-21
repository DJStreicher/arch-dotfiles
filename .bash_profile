#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
# Only launch Hyprland if we're on the first virtual terminal (e.g., tty1)
# if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
#     exec Hyprland
# fi

if [[ -z $DISPLAY ]] && [[ $XDG_VTNR -eq 1 ]]; then
    exec Hyprland
fi

echo "Running .bash_profile on VT $XDG_VTNR, DISPLAY=$DISPLAY" >> /tmp/hyprland-start.log
echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" >> /tmp/hyprland-start.log

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/dj/.lmstudio/bin"
# End of LM Studio CLI section

