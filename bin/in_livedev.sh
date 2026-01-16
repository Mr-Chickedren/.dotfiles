#!/bin/bash
set -e

echo "=== make partitions ==="
DISK=$1
read -rp "COUTION!! The contents of this disc will be erased. (${DISK}) 'YES'/other: " CONFIRM
if [ ! "$CONFIRM" == "YES" ]; then
	echo "stoped."
	exit 0
fi

# init GPT
sgdisk --zap-all "$DISK"

# remake
sgdisk --clear "$DISK"

# EFI System Partition (512M)
sgdisk \
  --new=1:0:+512M \
  --typecode=1:ef00 \
  --change-name=1:ARCH_EFI \
  "$DISK"

# root partition（-3G）
sgdisk \
  --new=2:0:-3G \
  --typecode=2:8300 \
  --change-name=2:ARCH_ROOT \
  "$DISK"

# swap
sgdisk \
  --new=3:0:0 \
  --typecode=3:8200 \
  --change-name=3:swap \
  "$DISK"

# reload
partprobe "$DISK"

# check
echo "done."
lsblk "$DISK" -o NAME,SIZE,TYPE,PARTLABEL,PARTTYPE


echo "=== format each partitions ==="
mkfs.fat -F32 "${DISK}p1"
mkfs.btrfs "${DISK}p2"
mkswap "${DISK}p3"
echo "done."

echo "=== mount each partitions ==="
mount "${DISK}p2" /mnt
mkdir -p /mnt/boot
mount "${DISK}p1" /mnt/boot
swapon "${DISK}p3" 
echo "done."
