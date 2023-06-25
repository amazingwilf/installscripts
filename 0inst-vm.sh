#!/usr/bin/env bash

vim /etc/pacman.conf

pacman-key --init && pacman-key --populate && pacman -Sy archlinux-keyring && pacman -Syy

umount -R /mnt

sgdisk -Z /dev/vda

sgdisk -a 2048 -o /dev/vda

sgdisk -n 1::+300M --typecode=1:ef00 --change-name=1:'EFIBOOT' /dev/vda
sgdisk -n 2::-0 --typecode=2:8300 --change-name=2:'ROOT' /dev/vda
partprobe /dev/vda

mkfs.vfat -F32 -n "EFIBOOT" /dev/vda1
mkfs.btrfs -L ROOT /dev/vda2 -f

mount /dev/vda2 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@snapshots
umount /mnt

mount -o noatime,compress=zstd,ssd,discard=async,subvol=@ /dev/vda2 /mnt
mkdir -p /mnt/{boot/efi,home,var/{cache,log},.snapshots,tmp}
mount /dev/vda1 /mnt/boot/efi
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@cache /dev/vda2 /mnt/var/cache
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@log /dev/vda2 /mnt/var/log
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@snapshots /dev/vda2 /mnt/.snapshots
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@home /dev/vda2 /mnt/home
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@tmp /dev/vda2 /mnt/tmp

reflector -c GB --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

pacstrap -K /mnt base linux-zen linux-firmware intel-ucode git wget neovim
genfstab -U /mnt >> /mnt/etc/fstab
cp /etc/pacman.conf /mnt/etc
