#!/usr/bin/env bash

vim /etc/pacman.conf

sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
sed -i 's/^#ParallelDownloads = 5/ParallelDownloads = 10\nILoveCandy/' /etc/pacman.conf

pacman -S --noconfirm --needed reflector rsync grub

pacman-key --init && pacman-key --populate && pacman -Sy archlinux-keyring && pacman -Syy

umount -R /mnt

sgdisk -Z /dev/sda

sgdisk -a 2048 -o /dev/sda

sgdisk -n 1::+300M --typecode=1:ef00 --change-name=1:'EFIBOOT' /dev/sda
sgdisk -n 2::-0 --typecode=2:8300 --change-name=2:'ROOT' /dev/sda
partprobe /dev/sda

mkfs.vfat -F32 -n "EFIBOOT" /dev/sda1
mkfs.btrfs -L ROOT /dev/sda2 -f

mount /dev/sda2 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@snapshots
umount /mnt

mount -o noatime,compress=zstd,ssd,discard=async,subvol=@ /dev/sda2 /mnt
mkdir -p /mnt/{boot/efi,home,var/{cache,log},.snapshots,tmp}
mount /dev/sda1 /mnt/boot/efi
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@cache /dev/sda2 /mnt/var/cache
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@log /dev/sda2 /mnt/var/log
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@snapshots /dev/sda2 /mnt/.snapshots
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@home /dev/sda2 /mnt/home
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@tmp /dev/sda2 /mnt/tmp

reflector -c GB --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

pacstrap -K /mnt base linux-zen linux-firmware intel-ucode git wget neovim
genfstab -U /mnt >> /mnt/etc/fstab
cp /etc/pacman.conf /mnt/etc
cp 1inst.sh /mnt/root/
