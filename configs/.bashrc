#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.config/bash/aliases.bash ]] && ~/.config/bash/aliases.bash

PS1='[\u@\h \w]\$ '
