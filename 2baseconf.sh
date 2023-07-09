#!/usr/bin/env bash

# Save workding directory for later use
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Install essential utilities
pacman -S git neovim fortune-mod exa doas bash-completion xdg-utils xdg-user-dirs neofetch

# Install AUR helper
mkdir -p ~/.local/src/ && cd ~/.local/src
git clone https://aur.archlinux.org/paru-bin
cd paru-bin && makepkg -si
cd $DIR

# Install essential utilities
pacman -S git neovim fortune-mod exa doas xdg-utils xdg-user-dirs neofetch
paru -S sparklines-git

# Enable doas
sudo cp configs/etc/doas.conf /etc && sudo chown root:roor /etc/doas.conf

# Shell configs
cp configs/.bashrc ~
cp -r configs/bash ~/.config/ 
cp -r configs/nvim ~/.config/

# Install xorg and lightdm
doas pacman -S xorg xclip lightdm lightdm-gtk-greeter

# Install xorg and lightdm configs
doas cp configs/X11/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf && doas chown root:root /etc/X11/xorg.conf.d/00-keyboard.conf
doas cp configs/lightdm/lightdm.conf /etc/lightdm/lightdm.conf && doas chown root:root /etc/lightdm/lightdm.conf
doas cp configs/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf && doas chown root:root /etc/lightdm/lightdm-gtk-greeter.conf
cp configs/.Xresources ~
cp -r configs/xrdb ~/.config/

# Install fonts
doas pacman -S noto-fonts noto-fonts-extra otf-aurulent-nerd otf-codenewroman-nerd otf-comicshanns-nerd otf-hermit-nerd otf-overpass-nerd ttf-anonymouspro-nerd ttf-bitstream-vera-mono-nerd ttf-cascadia-code-nerd ttf-daddytime-mono-nerd ttf-dejavu-nerd ttf-fantasque-nerd ttf-firacode-nerd ttf-hack-nerd ttf-inconsolata-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-liberation-mono-nerd ttf-meslo-nerd ttf-monofur-nerd ttf-mononoki-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono ttf-noto-nerd ttf-roboto-mono-nerd ttf-sourcecodepro-nerd ttf-terminus-nerd ttf-tinos-nerd ttf-ubuntu-mono-nerd ttf-ubuntu-nerd ttf-victor-mono-nerd 

# Install backgrounds
doas mkdir -p /usr/share/backgrounds && doas cp configs/wallpaper/* /usr/share/backgrounds

# Install bspwm & associated utilities
doas pacman -S bspwm sxhkd polybar dunst rofi dmenu lxappearance alacritty nitrogen
paru -S picom-jonaburg-git bibata-cursor-theme-bin flat-remix-gtk beautyline

# Install configs
cp -r configs/alacritty ~/.config/
cp -r configs/bspwm ~/.config/
cp -r configs/dunst ~/.config/
cp -r configs/nitrogen ~/.config/
cp -r configs/picom ~/.config/
cp -r configs/polybar ~/.config/
cp -r configs/rofi ~/.config/
cp -r configs/sxhkd ~/.config/

# Set up ssh keys and logins to hosts
sftp -P 222 www.badelephant.co.uk:config
mv config .ssh

ssh-keygen -t ed25519
ssh-copy-id bem
ssh-copy-id dotfiles

