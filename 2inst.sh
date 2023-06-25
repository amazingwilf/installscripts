#!/bin/bash

mkdir -p ~/.local/src
cd ~/.local/src
git clone https://aur.archlinux.org/paru-bin
cd paru-bin
makepkg -si



cd ~

doas pacman -S xorg lightdm lightdm-slick-greeter polkit-gnome alacritty lxappearance rofi nitrogen xclip ttf-jetbrains-mono-nerd noto-fonts noto-fonts-extra neofetch lolcat exa fortune-mod dunst xcolor imagemagick gpick jq

paru -S bibata-cursor-theme-bin picom-jonaburg-git sparklines-git lightdm-settings flat-remix flat-remix-gtk

sftp -P 222 www.badelephant.co.uk:config
mv config .ssh

ssh-keygen -t ed25519
ssh-copy-id bem
ssh-copy-id dotfiles

doas systemctl enable lightdm

