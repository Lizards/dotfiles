# Dotfiles


#### What it is

*Window manager and application settings*: i3, Polybar, rofi, `.Xresources`, urxvt, LXDM, xrandr, bash and Docker aliases, VS Code settings, etc...

Assumes system was bootstrapped using [my Arch installer scripts](https://github.com/Lizards/arch-installer).

- __.Xresources colors__: Modified "Sweet Love" from https://terminal.sexy/
- __GTK theme__: Generated from `.Xresources` using [Themix GUI designer](https://aur.archlinux.org/packages/themix-gui-git)
- __Cursor icons__: `adwaita`
- __Fonts__: `ttf-croscore`, `noto-fonts`, `ttf-ubuntu-font-family`, `tamsyn-font`, `ttf-font-awesome-4` (AUR), `ttf-ms-fonts` (AUR), `ttf-mplus` (AUR), `ttf-symbol` (AUR)
- __Other__: `xdg-open-server` (AUR)

#### What it's not

*System-level configuration*: pacman hooks, mouse settings, laptop settings (backlight/trackpad), bluetooth audio fixes, etc...  Those are in this repo: [arch-system-config](https://github.com/Lizards/arch-system-config)

## Installation

```
$ git clone --recurse-submodules https://github.com/Lizards/dotfiles
$ cd dotfiles
$ make
```
