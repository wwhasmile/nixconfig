# ❄️ My personal NixOS configuration ❄️

*This is declarative configuration for my own systems. Feel free to look around and copy if you want to!*

![GNOME Desktop as in this config](/assets/thumbnail.png)

---

## 🖥️ Info

The config uses flakes setup with [`home-manager`](https://github.com/nix-community/home-manager) for managing dotfiles, and [`Stylix`](https://github.com/nix-community/stylix/) for managing themes.

| Specification | Reference |
| --- | --- |
| Operating system | [`NixOS`](https://nixos.org/) |
| Shell | [`ZSH`](https://www.zsh.org/) + [`Spaceship`](https://github.com/spaceship-prompt/spaceship-prompt) |
| DE | [`GNOME`](https://www.gnome.org/uk/), [`KDE Plasma`](https://kde.org/uk/plasma-desktop/) |
| Fetcher | [`fastfetch`](https://github.com/fastfetch-cli/fastfetch) |
| Terminal | [`Alacritty`](https://alacritty.org/) |
| Editor | [`Zed`](https://zed.dev/) |
| Media player | [`VLC`](https://www.videolan.org/vlc/index.html) |
| Web browser | [`Librewolf`](https://librewolf.net/) |

## 📁 Structure

I tried to keep the structure more or less flat and simple, therefore no usual `modules/` folder.

* [`system/`](/system/) - system level modules. Contain stuff like generic hardware configuration and services.
* [`home/`](/home/) - home level modules. These are set up per individual user.
* [`themes/`](/themes/) - Stylix themes. Self explanatory.
* [`hosts/`](/hosts/) - my individual NixOS systems that use all the modules above.

System and home modules don't need to be manually imported, as any `.nix` file in these directories and their subdirectories is added automatically. Each folder in [`hosts/`](/hosts) is also treated as a separate host that gets autodetected by the flake.

## 🔥 Special thanks

* [`librephoenix/nixos-config`](https://github.com/librephoenix/nixos-config) - the main source of inspiration for my config before restructurization.
* [Official NixOS Wiki](https://wiki.nixos.org) for a lot of useful information.
* [MyNixOS](https://mynixos.com) for being a great help with packages and various configuration settings.
