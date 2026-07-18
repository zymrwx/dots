Arch Linux installation

# 1. archiso
## secure boot
Boot into UEFI:
    - restore factory keys
    - reset to setup mode
    - disable secure boot

then boot into archiso

> ![NOTE] virt-manager
> - Install `qemu-desktop` for UEFI (systemd-boot) and secure boot (sbctl)
> - Check `Customize configuration before install`
>   + `Overview` > `Hypervisor Details` > `Firmware` >
>     `UEFI x86_64: /usr/share/edk2/x64/OVMF_CODE.secboot*`
> - Boot into UEFI after finishing archiso with `systemctl reboot --firmware-setup`
>   + Go to `Device Manager` > `Secure boot Configuration` > `Custom mode`

## network
```sh
# read manual
iwctl help | less -R
# get device name
iwctl device list
# connect to a hidden SSID
iwctl station '<device_name>'
      connect-hidden '<SSID>'
      --passphrase '<passphrase>'
# verify connection
ping -c 3 archlinux.org
```

## timezone
```sh
timedatectl set-timezon Region/City
```

## partition
```sh
fdisk /dev/nvme0n1
```
- For a new disk, create a new GPT table with `g`
- For a old disk:
    1. print existing partition table with `p`
    2. delete a partition with `d`
    3. add a new partition with `n`
        - `+1G` for `/boot`
            + change partition type to `EFI` with `t` `1`
        - rest space for LUKS container
    4. write with `w`

## Filesystem

### boot
```sh
mkfs.fat -F 32 /dev/nvme0n1p1
```

### LVM on LUKS
```sh
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 cryptlvm

# optionally unlock existing partition
cryptsetup open /dev/nvme1n1p1 cryptdata

pvcreate /dev/mapper/cryptlvm
vgcreate vg0 /dev/mapper/cryptlvm
lvcreate -L 24G -n swap vg0
lvcreate -L 60G -n root vg0
lvcreate -l 100%FREE -n home vg0

mkswap /dev/vg0/swap
mkfs.ext4 /dev/vg0/root
mkfs.ext4 /dev/vg0/home
```

### mount
```sh
swapon /dev/vg0/swap

mount /dev/vg0/root /mnt
mkdir /mnt/{boot,home,data}
mount /dev/nvme0n1p1 /mnt/boot
mount /dev/vg0/home /mnt/home

# optionally mount existing partition
mount /dev/mapper/cryptdata /mnt/data
```

## pacstrap
```sh
# Change to a faster mirror
vim /etc/pacman.d/mirrorlist

pacman -Sy && pacman -S archlinux-keyring

pacstrap -K /mnt base base-devel linux-lts linux-lts-headers linux-firmware lvm2 \
    amd-ucode networkmanager vim man-db bash-completion sbctl efibootmgr
```
- replace `amd-ucode` with `intel-ucode` with intel CPU
- add `nvidia-open-dkms` with Nvidia GPU

## fstab
```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

# 2. arch-chroot
```sh
arch-chroot /mnt
```

## timezone
```sh
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc
```

## locale
uncomment locale in `/etc/locale.gen`
```conf
en_US.UTF-8 UTF-8
```

```sh
locale-gen

echo 'LANG=en_US.UTF-8' > /etc/locale.conf
```

## host
```sh
echo '<hostname>' > /etc/hostname
```

## crypttab (optional with more than 1 encrypted disks)
```sh
# optional
# add a new key
cryptsetup luksAddKey /dev/nvme1n1p1
# list old keys
cryptsetup luksDump /dev/nvme1n1p1 | less
# delete old keys
cryptsetup luksKillSlot /dev/nvme1n1p1 0

# generate a key
dd if=/dev/urandom of=/root/cryptkey bs=1024 count=4
chmod 400 /root/cryptkey
chattr +i /root/cryptkey
cryptsetup luksAddkey /dev/nvme1n1p1 /root/cryptkey

echo '#'$(blkid | grep '/dev/nvme1n1p1') >> /etc/crypttab
```

Edit `/etc/cryptkey` to:
```conf
# <name>    <device>         <password>          <options>
data    UUID=xxxxxx-xxxxx    /root/cryptkey     luks,discard
```

## initramfs
Edit `/etc/mkinitcpio.conf`:
```sh
HOOKS=(base systemd autodetect microcode modconf keyboard sd-vconsole block sd-encrypt lvm2 filesystems fsck)
```
- `kms` is removed to avoid early resolution change in `sd-encrypt`'s prompt
- `sd-encrypt` is added to unlock LUKS container
- `lvm2` is added to enable LVM2 volumes

```sh
mkinitcpio -P
```

## bootloader
```sh
bootctl install
```

Add below to `/boot/loader/loader.conf`:
```conf
default arch.conf
```

```sh
vim /boot/loader/entries/arch.conf
```

In vim to get UUIDs:
```vim
:r !blkid
:r !ls /boot
```

Edit file:
```conf
title Arch Linux
initrd /initramfs-linux-lts.img
linux /vmlinuz-linux-lts
options rd.luks.name=xxxx-xxxx=cryptlvm root=UUID=xxxx-xxxx
```
- `rd.luks.name` uses UUID of LUKS container `/dev/nvme0n1p2`, ignore this if
  root is not encrypted
- `root` uses UUID of `/dev/vg0/root`
- for other kernels, e.g. `linux-lts`, change to `/vmlinuz-linux-lts`

```sh
systemctl enable systemd-boot-update.service`
```

## Users
```sh
# create password for root
passwd

useradd -G wheel -m user
passwd user
```

```sh
visudo
```
Uncomment:
```sudoers
%wheel ALL=(ALL:ALL) ALL
```

## exit archiso
```sh
# exit chroot
exit

swapoff -a
umount -R /mnt

reboot
```

# 3. Post Installation
Login as user.

> [!Tip]
> If you use systemd-boot and systemd-boot-update.service, the boot loader is
> only updated after a reboot, and the sbctl pacman hook will therefore not sign
> the new file.
>
> As a workaround, it can be useful to sign the boot loader directly in
> /usr/lib/, as bootctl install and update will automatically recognize and
> copy .efi.signed files to the ESP if present, instead of the normal .efi file

> [!Note]
> Files /boot/EFI/BOOT/BOOTX64.EFI and /boot/EFI/systemd/systemd-bootx64.efi
> are identical.
>
> When you run bootctl install or bootctl update, it copies the exact same
> binary from /usr/lib/systemd/boot/efi/systemd-bootx64.efi to both location

```sh
sudo sbctl create-keys

# on Thinkpad, unset immutable to files
sudo chattr -i /sys/firmware/efi/efivars/KEK-*
sudo chattr -i /sys/firmware/efi/efivars/db-*

sudo sbctl enroll-keys -m
sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
sudo sbctl sign -s /boot/EFI/systemd/systemd-bootx64.efi
sudo sbctl sign -s /boot/vmlinuz-linux
sudo sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi


sudo sbctl verify
```
reboot into UEFI again, secure boot should be in `User` mode, enable secure
boot if it is not automatically enabled.

> ![NOTE] virt-manager
> Secure boot should have been automatically enabled

## network
```sh
sudo systemctl enable --now NetworkManager.service
nmcli device wifi \
      connect '<SSID>' \
      password '<password>' \
      hidden yes
```
- The first attempt to connect to a hidden SSID will always fail.
