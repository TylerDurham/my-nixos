```
███╗   ███╗██╗   ██╗    ███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗
████╗ ████║╚██╗ ██╔╝    ████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝
██╔████╔██║ ╚████╔╝     ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗
██║╚██╔╝██║  ╚██╔╝      ██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║
██║ ╚═╝ ██║   ██║       ██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║
╚═╝     ╚═╝   ╚═╝       ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
```                                                           
<div align="center">
  <p><img src="https://raw.githubusercontent.com/TylerDurham/my-nixos/refs/heads/master/nixos.png" width="200"/></p>
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
| [my-mvc.vim](https://github.com/TylerDurham/my-mvc.vim)   | My minimal `vim` config. |


## Structure

```
flake.nix              # Entrypoint — nixpkgs-unstable + home-manager
configuration.nix      # Shared NixOS config imported by all hosts
hosts.nix              # Per-host module toggles and settings
hardware/              # Per-host hardware configurations
modules/desktop.nix    # Desktop environment module (Hyprland, audio, bluetooth)
modules/home.nix       # Home Manager entry point
modules/home/          # Home Manager modules (shell, git, gtk, development)
modules/system/        # NixOS system modules (shell, docker, plymouth, sshd)
```

## Features

- **Hyprland** — Wayland compositor with XWayland support
- **Plymouth** — Graphical boot splash (`lone` preset, silent boot, systemd initrd)
- **Home Manager** — Declarative user environment (Neovim, Ghostty, Kitty, Waybar, Rofi, Starship, swww)
- **Audio** — PipeWire via `modules/system/audio.nix`
- **Bluetooth** — Optional via `modules/system/bluetooth.nix`
- **1Password** — System-level GUI + CLI integration
- **Fingerprint** — `fprintd` enabled for sudo and polkit-1 authentication

## System Packages

`bat` `btop` `curl` `envsubst` `fzf` `gvfs` `gzip` `jq` `lsd` `ncdu` `neovim` `ripgrep` `starship` `stow` `tmux` `tree` `unzip` `vim` `wget` `yazi` `zoxide`

**Font:** JetBrains Mono Nerd Font

## Home Packages

**Media:** `imv` `mpv` `pinta` `playerctl` `plex-desktop` `plexamp` `spotify` `vlc`

**Desktop:** `ghostty` `kitty` `libnotify` `rofi` `swaynotificationcenter` `swayosd` `swww` `waybar` `yazi`

**Utility:** `brightnessctl` `grimblast` `libsecret` `neovim` `pavucontrol` `starship` `wl-clipboard`

**Development** *(host-level toggle via `modules.development.enable`)*: `black` `bun` `gcc` `github-cli` `gnumake` `go` `gopls` `gotools` `hugo` `isort` `just` `nixd` `nodejs` `prettier` `python3` `stylua` `tree-sitter` `uv` + `mise` for runtime version management

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

### Fingerprint Enrollment

List enrolled fingerprints for the current user:

```shell
fprintd-list $USER
```

Enroll a finger (default: `right-index-finger`):

```shell
fprintd-enroll
```

To enroll a specific finger, pass `-f <finger>`. Valid finger names: `left-thumb`, `left-index-finger`, `left-middle-finger`, `left-ring-finger`, `left-little-finger`, `right-thumb`, `right-index-finger`, `right-middle-finger`, `right-ring-finger`, `right-little-finger`.

Verify an enrolled finger:

```shell
fprintd-verify
```

### Rebuild

```bash
# Build and switch (replace <host> with erebor, imladris, or nixvm)
sudo nixos-rebuild switch --flake .#<host>
```
There are two utility aliases for bash and zsh that will rebuild and garbage collect, respectively. 
The hostname is determined in the alias, so you don't need to specify the host name.

**Rebuild and switch**

``` shell
nix-rbs
```

**Build only (no activation)**

``` shell
nix-rbb
```

**Test (activate, no persistence across reboot)**

``` shell
nix-rbt
```

**Garbage Collect**

``` shell
nix-gc
```

## License

[MIT](LICENSE)
