#!/usr/bin/env bash

vim /etc/pacman.conf

umount -R /mnt

sgdisk -Z /dev/nvme0n1
sgdisk -Z /dev/nvme1n1
sgdisk -Z /dev/sda

sgdisk -a 2048 -o /dev/nvme0n1
sgdisk -a 2048 -o /dev/nvme1n1
sgdisk -a 2048 -o /dev/sda

sgdisk -n 1::+300M --typecode=1:ef00 --change-name=1:'EFIBOOT' /dev/nvme0n1
sgdisk -n 2::-0 --typecode=2:8300 --change-name=2:'ROOT' /dev/nvme0n1
partprobe /dev/nvme0n1

sgdisk -n 1::-0 --typecode=1:8300 --change-name=1:'HOME' /dev/nvme1n1
partprobe /dev/nvme1n1

sgdisk -n 1::-0 --typecode=1:8300 --change-name=1:'IMAGES' /dev/sda
partprobe /dev/sda

mkfs.vfat -F32 -n "EFIBOOT" /dev/nvme0n1p1
mkfs.btrfs -L ROOT /dev/nvme0n1p2 -f
mkfs.btrfs -L HOME /dev/nvme1n1p1 -f
mkfs.btrfs -L IMAGES /dev/sda1 -f

mount /dev/nvme0n1p2 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@snapshots
umount /mnt

mount /dev/nvme1n1p1 /mnt
btrfs subvolume create /mnt/@home
umount /mnt

mount /dev/sda1 /mnt
btrfs subvolume create /mnt/@images
umount /mnt

mount -o noatime,compress=zstd,ssd,discard=async,subvol=@ /dev/nvme0n1p2 /mnt
mkdir -p /mnt/{boot/efi,home,var/{cache,log,lib/libvirt/images},.snapshots}
mount /dev/nvme0n1p1 /mnt/boot/efi
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@cache /dev/nvme0n1p2 /mnt/var/cache
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@log /dev/nvme0n1p2 /mnt/var/log
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@snapshots /dev/nvme0n1p2 /mnt/.snapshots
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@home /dev/nvme1n1p1 /mnt/home
mount -o noatime,compress=zstd,ssd,discard=async,subvol=@images /dev/sda1 /mnt/var/lib/libvirt/images

reflector -c GB --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

pacman-key --init
pacman-key --populate
pacman -Syy

pacstrap -K /mnt base linux-zen linux-firmware intel-ucode git wget neovim
genfstab -U /mnt >> /mnt/etc/fstab
cp /etc/pacman.conf /mnt/etc
