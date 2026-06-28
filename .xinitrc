#!/bin/sh

export GTK_IM_MODULE="fcitx"
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE="fcitx"

export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_STYLE_OVERRIDE="Adwaita-dark"
export GTK_THEME="Adwaita-dark"

for i in $(xinput list | grep -i "touchpad" | grep -oP 'id=\K[0-9]+'); do
    xinput set-prop "$i" "libinput Tapping Enabled" 1
done

xset r rate 200 30

xset s on

xset s 960

xss-lock -- slock &

echo 'Xft.dpi: 96' | xrdb -m

xrandr -s 1920x1080

redshift -P -O 5000

dunst &

picom &

clipmenud &

fcitx5 -d &

dwmblocks &

ssh-agent dwm
