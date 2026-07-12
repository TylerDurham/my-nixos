{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.desktop;
in
{
  imports = [
    ../system/audio.nix
    ../system/bluetooth.nix
    ../system/shell.nix
    ../system/utility.nix
    ../system/plymouth.nix
    ../system/docker.nix
    ./hyprland.nix
  ];

  options.modules.desktop = {
    enable = mkEnableOption "Desktop packages and services.";
  };

  config = mkIf cfg.enable {
    modules.hyprland.enable = true;
    modules.bluetooth.enable = true;
    modules.audio.enable = true;

    environment.systemPackages = with pkgs; [
      brightnessctl          # screen and keyboard brightness control
      gnome-keyring
      ghostty                # GPU-accelerated terminal emulator
      grimblast              # Hyprland screenshot tool (wraps grim + slurp)
      imv                    # lightweight Wayland image viewer
      inotify-tools          # filesystem event monitoring utilities
      kitty                  # GPU-accelerated terminal emulator
      libappindicator-gtk3   # system tray indicator support for GTK apps
      libnotify              # desktop notification library (notify-send)
      libsecret              # keyring access library (GNOME secrets)
      mpv                    # general-purpose media player
      nautilus               # GTK file manager
      neovim                 # extensible terminal text editor
      nerd-fonts.jetbrains-mono # monospace font with icon glyphs
      nwg-look               # GTK theme switcher for wlroots compositors
      obsidian               # markdown knowledge base / note-taking
      pavucontrol            # PulseAudio/PipeWire volume control GUI
      pinta                  # simple image editor
      playerctl              # MPRIS media player controller
      plex-desktop           # Plex media player desktop app
      plexamp                # Plex music player
      rofi                   # application launcher and window switcher
      signal-desktop         # encrypted messaging client
      spotify                # music streaming client
      starship               # cross-shell prompt
      swaynotificationcenter # notification center for wlroots compositors
      swayosd                # on-screen display for volume/brightness
      swww                   # Wayland wallpaper daemon with transitions
      vlc                    # versatile media player
      waybar                 # highly customizable Wayland status bar
      wl-clipboard           # Wayland clipboard utilities (wl-copy/wl-paste)
      xdg-terminal-exec      # XDG default terminal launcher spec
    ];
  };

}
