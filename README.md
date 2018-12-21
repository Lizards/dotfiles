# Dotfiles


#### What it is

*Window manager and application settings*: i3, Polybar, rofi, `.Xresources`, urxvt, LXDM, xrandr, bash and Docker aliases, Sublime Text, redshift, etc...

Assumes system was bootstrapped using [my Arch installer scripts](https://github.com/Lizards/arch-installer).  For best results, install:

- __GTK theme__: `gtk-theme-solarc-git` (AUR)
- __Icons__: `arc-icon-theme`
- __Fonts__: `ttf-croscore`, `noto-fonts`, `ttf-ubuntu-font-family`, `tamsyn-font`, `ttf-font-awesome-4` (AUR), `ttf-ms-fonts` (AUR), `ttf-mplus` (AUR), `ttf-symbol` (AUR)
- __Sublime Text__: [Neon Color Scheme](https://packagecontrol.io/packages/Neon%20Color%20Scheme), [FileIcons](https://packagecontrol.io/packages/FileIcons), Boxy Theme ([now defunct](https://forum.sublimetext.com/t/boxy-da-ui-theme-missing/40862/2); [install manually from fork](https://github.com/Lizards/boxy))
- __Other__: `xdg-open-server` (AUR)

#### What it's not

*System-level configuration*: pacman hooks, mouse settings, laptop settings (backlight/trackpad), bluetooth audio fixes, etc...  Those are in this repo: [arch-system-config](https://github.com/Lizards/arch-system-config)

## Installation

```
$ git clone --recurse-submodules https://github.com/Lizards/dotfiles 
$ cd dotfiles
$ make
```
