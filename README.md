```
███╗   ███╗██╗   ██╗    ███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗
████╗ ████║╚██╗ ██╔╝    ████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝
██╔████╔██║ ╚████╔╝     ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗
██║╚██╔╝██║  ╚██╔╝      ██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║
██║ ╚═╝ ██║   ██║       ██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║
╚═╝     ╚═╝   ╚═╝       ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
```                                                           
<div align="center">
  <p><img src="https://raw.githubusercontent.com/TylerDurham/my-nixos/refs/heads/master/media/nixos.png" width="200"/></p>
  <p>My personal NixOS configuration with Hyprland, managed via flakes and Home Manager.</p>
</div>

## Hosts

| Name | Arch | Notes |
|------|------|-------|
| `erebor` | x86_64 | Laptop, LUKS-encrypted root |
| `imladris` | x86_64 | Laptop |
| `nixvm` | x86_64 | VM |

## Optional Dependancies

| Name                                                      | Description             |
|-----------------------------------------------------------|-------------------------|
| [my-shell](https://github.com/TylerDurham/my-shell)       | My `shell` dotfiles.    |
| [my-hyprland](https://github.com/TylerDurham/my-hyprland) | My `Hyprland` dotfiles. |
| [my-neovim](https://github.com/TylerDurham/my-neovim)     | My `NeoVim` dotfiles.   |


## Structure

```
flake.nix              # Entrypoint — nixpkgs-unstable + home-manager
configuration.nix      # Shared NixOS config imported by all hosts
hosts/                 # Per-host hardware configurations
system/                 # NixOS modules (audio, hyprland, packages, plymouth, programs, users)
home.nix               # Home Manager entrypoint
home/                  # User-level config (bash, zsh, git, gtk, xdg, packages, dev tools)
```

## Features

- **Hyprland** — Wayland compositor with XWayland support
- **Plymouth** — Graphical boot splash (`lone` preset, silent boot, systemd initrd)
- **Home Manager** — Declarative user environment (Neovim, Ghostty, Kitty, Waybar, Rofi, Starship, swww)
- **Audio** — PipeWire via `system/audio.nix`
- **1Password** — System-level GUI + CLI integration

## System Packages

`bat` `curl` `fzf` `hypridle` `hyprlock` `hyprsunset` `jq` `lsd` `power-profiles-daemon` `ripgrep` `stow` `tmux` `vim` `wget` `xdg-terminal-exec` `zoxide`

**Font:** JetBrains Mono Nerd Font

## Home Packages

**Media:** `plexamp` `plex-desktop` `spotify` `pavucontrol` `playerctl`

**Desktop:** `brightnessctl` `ghostty` `kitty` `libnotify` `nautilus` `nwg-look` `rofi` `rustdesk` `signal-desktop` `swaynotificationcenter` `swayosd` `swww` `waybar`

**Dev:** `hyprlauncher` `hyprshutdown` `inotify-tools` `libsecret` `neovim` `starship` `wl-clipboard`

## Usage

### Install

#### Disk Preparation

**IMPORTANT:** I don't use a display manager like `sddm`. This hardware setup assumes your main disk is encrypted. While you 
can certainly modify, unless you encrypt your disk and/or use a display manager, using this configuration leaves you vulnerable. 

Basic `LUKS` encryption setup (Assuming `UEFI` boot, swap, and OS partitions on a modern `NVME` drive):

``` shell
cryptsetup luksFormat /dev/nvme0n1p3
cryptsetup luksOpen /dev/nvme0n1p3 cryptroot
mkfs.ext4 /dev/mapper/cryptroot

```

### Rebuild

```bash
# Build and switch (replace <host> with erebor, imladris, or nixvm)
sudo nixos-rebuild switch --flake .#<host>
```
There are two utility aliases for bash and zsh that will rebuild and garbage collect, respectively. 
The hostname is determined in the alias, so you don't need to specify the host name.

**Rebuild**

``` shell
nix-rb
```
**Garbage Collect**

``` shell
nix-gc
```

## License

[MIT](LICENSE)
