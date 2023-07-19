#!/usr/bin/env bash

sudo mkdir -p $HOME/.config

dirs=( "alacritty" "bash" "dunst" "nvim" "picom" "xrdb" )
for dir in ${dirs[@]}
do
    cp -r $dir $HOME/.config/
done

mkdir -p $HOME/.local/share
cp -r dwm $HOME/.local/share

cp Xresources $HOME/.Xresources
cp bashrc $HOME/.bashrc

