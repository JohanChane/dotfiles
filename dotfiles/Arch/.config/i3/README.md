## Dependencies

```sh
# ## xorg
paru -S xorg xorg-xrdb

# ## Display manager
paru -S ly

# ## i3
paru -S i3

# ## i3blocks
paru -S i3blocks i3blocks-contrib

# ## portal
paru -S xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-gnome

# ## polkit
paru -S polkit-gnome

# ## rofi, dunst
paru -S papirus-icon-theme

# ## lock
paru -S xss-lock

# ## idle
paru -S xidlehook

# ## compositor and background color
paru -S xcompmgr hsetroot

# ## backlight
paru -S ddcci-driver-linux-dkms ddcutil

# ## rofi
paru -S rofi

# ## terminal
paru -S ghostty
```

## Config ddcutil

```sh
sudo usermod -aG i2c $USER    # relogin
```
