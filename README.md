# arch linux dev

## TODO before clone this (in live dev)

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
|root|Enter|-3G  |Enter|ARCH\-ROOT|
|swap|Enter|Enter|8200 |swap      |

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

pacstrap /mnt base linux linux-firmware vim iwd git sudo
```

### 7. remind mounts
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

### 8. change root
```bash
arch-chroot /mnt
```

### 9. make password for root
```bash
passwd
```

### 10. add user and append groups
```bash
useradd [username]
passwd [username]

usermod -aG wheel audio [username]
```

### 11. add sudo user
```bash
EDITOR=vim visudo
```

### 12. install boot-manager
TODO: want to use systemd-boot
