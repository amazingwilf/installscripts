#!/bin/bash


ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
sed -i '154s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf
echo "osiris" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 osiris.localdomain osiris" >> /etc/hosts
echo root:S3raph1m | chpasswd

pacman-key --init && pacman-key --populate && pacman -Sy archlinux-keyring && pacman -Syy
pacman -S grub efibootmgr networkmanager dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils bluez bluez-utils man doas tlp alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call acpid terminus-font xf86-video-amdgpu

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB 

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
systemctl enable tlp
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable acpid

useradd -m david
echo david:S3raph1m | chpasswd
usermod -aG wheel,input,video david

echo "david ALL=(ALL) ALL" >> /etc/sudoers.d/david

echo "permit nopass david" > /etc/doas.conf
