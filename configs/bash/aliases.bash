export EDITOR=nvim
export VISUAL=nvim

alias c='clear'
alias s='source $HOME/.bashrc'
alias nv='$EDITOR'


alias cds='cd $HOME/.local/src'
alias cdd='cd $HOME/.local/src/dwm'
alias cdc='cd $HOME/.config'

#Pacman for software managment
alias pacman='doas pacman'
alias search='doas pacman -Qs'
alias remove='doas pacman -Rcns'
alias pinstall='doas pacman -S'
alias linstall='doas pacman -U '
alias update='doas pacman -Syyu && flatpak update'
alias clrcache='doas pacman -Scc'
alias orphans='doas pacman -Rns $(pacman -Qtdq)'
alias akring='doas pacman -Sy archlinux-keyring --noconfirm'

alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

alias ..='cd ..'
alias ...='cd ../../'

alias na='$EDITOR $HOME/.confit/bash/aliases.bash'
alias nau='$EDITOR $HOME/.local/share/dwm/autostart.sh'
alias nb='$EDITOR $HOME/.bashrc'
alias nd='$EDITOR $HOME/.local/src/dwm/config.def.h'
alias nx='$EDITOR $HOME/.Xresources'
alias nz='$EDITOR $HOME/.zshrc'

alias free='free -mt'
alias wget='wget -c'
alias df='df -h'

alias rd='rm -r'
alias cpd='cp -R'

alias neofetch='neofetch | lolcat'
alias nf='neofetch'

alias home='cd $HOME'
alias etc='cd /etc/'
alias music='cd $HOME/Music'
alias vids='cd $HOME/Videos'
alias conf='cd $HOME/.config'
alias desk='cd $HOME/Desktop'
alias pics='cd $HOME/Pictures'
alias dlds='cd $HOME/Downloads'
alias docs='cd $HOME/Documents'
alias src='cd $HOME/.local/src'
alias ddwm='cd $HOME/suckless/dwm'
alias omz='cd $HOME/.oh-my-zsh'
alias suck='cd $HOME/suckless'
alias lbin='cd $HOME/.local/bin'

alias info='pacman -Si'
alias infox='pacman -Sii'

alias mall='make clean && make && doas make install'
alias merge='xrdb -merge $HOME/.Xresources'

alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l='exa -lah --color=always --group-directories-first --icons' # tree listing

alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push origin master'
alias gs='git status'

alias po='poweroff'
alias rb='reboot'

alias cps='doas cp'
alias mvs='doas mv'
