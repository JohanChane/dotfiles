## Installation

```sh
paru -S niri-git gammastep brightnessctl xwayland-satellite
paru -S swayidle
paru -S quickshell-git dms-shell-niri gammastep

# ## portal
paru -S xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-gnome
# ## polkit
paru -S polkit-gnome

paru -S wl-clipboard
```

```sh
paru -S rofi
```

```sh
systemctl enable xwayland-satellite.service --user
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

## 查看 autostart

```sh
dex -ad
```

## References

-   [niri config example](https://linux.do/t/topic/861559?page=3)
