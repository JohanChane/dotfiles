## Installation

```sh
paru -S niri-git brightnessctl xwayland-satellite
paru -S waybar otf-font-awesome
paru -S swayidle swaync
paru -S swaylock-effects swaybg

# ## portal
paru -S xdg-desktop-portal
paru -S xdg-desktop-portal-gtk xdg-desktop-portal-gnome xdg-desktop-portal-wlr
# ## polkit
paru -S polkit-gnome
# ## Secret portal
paru -S gnome-keyring

paru -S wl-clipboard
```

```sh
paru -S rofi
```

```sh
systemctl enable xwayland-satellite.service --user
systemctl enable swaync --user
systemctl enable --user gnome-keyring-daemon.service
```

## flameshot

```sh
paru -S grim
```

~/.config/flameshot/flameshot.ini:

```ini
disabledGrimWarning=true
useGrimAdapter=true
```

## rofi

```sh
paru -S papirus-icon-theme
```


## fcitx5 theme

```sh
paru -S fcitx5-skin-ori-git
```

## 查看 autostart

```sh
dex -ad
```

## fcitx5 in wayland

See [Using Fcitx 5 on Wayland](https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland/zh-cn)

**不要设置 GTK_IM_MODULE 环境变量！**

~/.gtkrc-2.0:

```ini
gtk-im-module="fcitx"
```

~/.config/gtk-3.0/settings.ini:

```ini
[Settings]
gtk-im-module=fcitx
```

~/.config/gtk-4.0/settings.ini:

```ini
[Settings]
gtk-im-module=fcitx
```

## References

-   [niri config example](https://linux.do/t/topic/861559?page=3)
