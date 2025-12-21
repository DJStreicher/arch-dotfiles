#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '
# PS1='\W \$ '
PS1='\W  '

alias vim='nvim'

# PATHS
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export PATH=$HOME/.local/bin:$PATH

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/dj/.lmstudio/bin"
# End of LM Studio CLI section

