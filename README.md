# my-nixos

Personal NixOS configuration with Hyprland, managed via flakes and Home Manager.

## Hosts

| Name | Arch | Notes |
|------|------|-------|
| `erebor` | x86_64 | Laptop, LUKS-encrypted root |
| `imladris` | x86_64 | Laptop |
| `nixvm` | x86_64 | VM |

## Structure

```
flake.nix              # Entrypoint — nixpkgs-unstable + home-manager
configuration.nix      # Shared NixOS config imported by all hosts
hosts/                 # Per-host hardware configurations
nixos/                 # NixOS modules (audio, hyprland, packages, plymouth, programs, users)
home.nix               # Home Manager entrypoint
home/                  # User-level config (bash, zsh, git, gtk, xdg, packages, dev tools)
```

## Features

- **Hyprland** — Wayland compositor with XWayland support
- **Plymouth** — Graphical boot splash (`lone` preset, silent boot, systemd initrd)
- **Home Manager** — Declarative user environment (Neovim, Ghostty, Kitty, Waybar, Rofi, Starship, swww)
- **Audio** — PipeWire via `nixos/audio.nix`
- **1Password** — System-level GUI + CLI integration

## System Packages

`bat` `curl` `fzf` `hypridle` `hyprlock` `hyprsunset` `jq` `lsd` `ripgrep` `stow` `tmux` `vim` `wget` `zoxide`

**Font:** JetBrains Mono Nerd Font

## Home Packages

**Media:** `plexamp` `plex-desktop` `spotify` `pavucontrol`

**Desktop:** `ghostty` `kitty` `nautilus` `rofi` `waybar` `swww` `swaynotificationcenter` `swayosd` `nwg-look`

**Dev:** `neovim` `starship` `wl-clipboard` `hyprlauncher` `hyprshutdown`

## Usage

```bash
# Build and switch (replace <host> with erebor, imladris, or nixvm)
sudo nixos-rebuild switch --flake .#<host>
```

## License

[MIT](LICENSE)
