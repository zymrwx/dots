Termux on android setup

# 1. adb
1. Enable developer mode
2. Enable adb and install package
3. Install APK
```sh
adb install PATH
```

# 2. termux
```sh
termux-setup-storage

termux-change-repo

apt upgrade

apt install fish vim openssh rsync lf

echo "command -v fish >/dev/null && exec fish" > .bashrc

# Uncomment and change to:
# PasswordAuthentication no
vim $PREFIX/etc/ssh/sshd_config
```

# 3. ssh pubkey
Use adb to send pub key to android phone
```sh
# Other path would have permission issues
adb push ~/.ssh/id_ed25519.pub /sdcard
```

On termux:
```sh
cat /sdcard/id_ed25519.pub >> ~/.ssh/authorized_keys
rm /sdcard/id_ed25519.pub
```

# 4. connect
On termux:
```sh
sshd

# checkwith
pgrep sshd

# end
pkill -x sshd
```

On linux:
```sh
ssh -p 8022 192.168.xx.xx
```

- Termux default port is `8022` (it cannot use the common `22` without root)

- Termux username is fixed and assigned by Android when Termux is installed.
  When you SSH into Termux, the server ignores whatever username you send and
  logs you into the same environment anyway. Not specifying a username sends
  the local username, and Termux ignores it and it works.

# 5. rsync over ssh
While in termux via SSH:
```sh
mkdir -p /data/data/com.termux/files/home/storage/shared/data
```

Example to sync files to android on linux:
```sh
rsync -e 'ssh -p 8022' -avh --progress ~/mus 192.168.xx.xx:/data/data/com.termux/files/home/storage/shared/data/
```
