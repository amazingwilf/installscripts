#!/bin/bash

mkdir -p ~/.local/src
cd ~/.local/src
git clone https://aur.archlinux.org/paru-bin
cd paru-bin
makepkg -si



cd ~

# xorg base packages
doas pacman -S xorg lightdm lightdm-gtk-greeter polkit-gnome xclip

# gnome desktop
doas pacman -S gnome gnome-extra gnome-tweaks

# dwm requirements
doas pacman -S alacritty lxappearance rofi nitrogen dunst xcolor imagemagick gpick jq 

# fonts
noto-fonts noto-fonts-extra otf-aurulent-nerd otf-codenewroman-nerd otf-comicshanns-nerd otf-hermit-nerd otf-overpass-nerd ttf-anonymouspro-nerd ttf-bitstream-vera-mono-nerd ttf-cascadia-code-nerd ttf-daddytime-mono-nerd ttf-dejavu-nerd ttf-fantasque-nerd ttf-firacode-nerd ttf-hack-nerd ttf-inconsolata-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-liberation-mono-nerd ttf-meslo-nerd ttf-monofur-nerd ttf-mononoki-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono ttf-noto-nerd ttf-roboto-mono-nerd ttf-sourcecodepro-nerd ttf-terminus-nerd ttf-tinos-nerd ttf-ubuntu-mono-nerd ttf-ubuntu-nerd ttf-victor-mono-nerd 

# misc apps
doas pacman -S neofetch lolcat exa fortune-mod firefox firefox-i18n-en-gb

paru -S bibata-cursor-theme-bin picom-jonaburg-git sparklines-git lightdm-settings flat-remix flat-remix-gtk

sftp -P 222 www.badelephant.co.uk:config
mv config .ssh

ssh-keygen -t ed25519
ssh-copy-id bem
ssh-copy-id dotfiles

doas systemctl enable lightdm

