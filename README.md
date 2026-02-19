# arch linux dev

## in live dev

### 1. connect network (if you use wifi)
```bash
iwctl

> station *** scan
> staionn *** connect ***
```

### 2. make partition
check your disk
```bash
lsblk
```
> [!NOTE]
> Maybe... you can find device-name
> For example... 'nvme###' 'sda###'

make it
```bash
cgdisk /dev/nvme*n*
```

delete all current partitions and serect 'new' in freespace
|par |Q1   |Q2   |Q3   |Q4        |
|:---|:---:|:---:|:---:|:--------:|
|efi |Enter|+512M|ef00 |ARCH\_EFI |
|root|Enter|-3G  |Enter|ARCH\_ROOT|
|swap|Enter|Enter|8200 |ARCH\_SWAP|

### 3. format each partitions
```bash
mkfs.fat -F32 [EFI partition]
mkfs.btrfs [ROOT partition]
mkswap [swap partition]
```

### 4. mount each partitions
```bash
mount [ROOT partition] /mnt
mkdir /mnt/boot
mount [EFI partition] /mnt/boot
swapon [swap partition]
```

### 5. edit mirror list
```bash
vim /etc/pacman.d/mirrorlist
```
> [!NOTE]
> plz find Japan block, set top in this file and uncomment japan-server

### 6. install init env
```bash
pacman -Sy archlinux-keyring

pacstrap /mnt base linux linux-firmware vim iwd dhcpcd sudo
```

### 7. remind mounts
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

### 8. change root
```bash
arch-chroot /mnt
```

## chroot

### 1. make password for root
```bash
passwd
```

### 2. add user and append groups
```bash
useradd [username]
passwd [username]

usermod -aG wheel audio [username]
```

### 3. add sudo user
```bash
EDITOR=vim visudo
```

### 4. install other
```bash
pacman -Syu
pacman -S amd-ucode git
```

### 5. install boot-manager
```bash
bootctl install
```
edit /boot/loader/loader.conf
```bash
default arch
timeout menu-force
console-mode max
editor no
```
edit /boot/loader/entries/arch.conf
```bash
title Arch Linux
linx /vmlinuz-linux
initrd /initramfs-linux.img
options root=PARTUUID=[ROOT partition PARTUUID] rw quiet
```
> [!NOTE]
> you can find PARTUUID when run ```blkid | grep ARCH_ROOT```
> plz check ```bootctl list``` and confirm that default is "arch"


## before reboot

### 1. enable network services
```bash
sudo systemctl enable --now iwd
sudo systemctl enable --now dhcpcd
```

