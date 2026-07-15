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
    ./system/audio.nix
    ./system/bluetooth.nix
    ./system/fingerprint.nix
    ./system/shell.nix
    ./system/sshd.nix
    ./system/utility.nix
    ./system/plymouth.nix
    ./system/docker.nix
    ./system/desktops/hyprland.nix
  ];

  options.modules.desktop = {
    enable = mkEnableOption "Desktop packages and services.";
  };

  config = mkIf cfg.enable {
    services.fprintd.enable = true;
    security.pam.services.sudo.fprintAuth = true;
    security.pam.services.polkit-1.fprintAuth = true;

    modules.hyprland.enable = true;
    modules.bluetooth.enable = true;
    modules.audio.enable = true;
    modules.fingerprint.enable = true;

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      (callPackage ./system/fonts/sf-pro.nix {})
      (callPackage ./system/fonts/bio-rhyme.nix {})
      (callPackage ./system/fonts/special-elite.nix {})
    ];


    environment.systemPackages = with pkgs; [
      brightnessctl             # screen and keyboard brightness control
      gnome-keyring
      ghostty                   # GPU-accelerated terminal emulator
      grimblast                 # Hyprland screenshot tool (wraps grim + slurp)
      imagemagick
      imv                       # lightweight Wayland image viewer
      inotify-tools             # filesystem event monitoring utilities
      kitty                     # GPU-accelerated terminal emulator
      libappindicator-gtk3      # system tray indicator support for GTK apps
      libnotify                 # desktop notification library (notify-send)
      libsecret                 # keyring access library (GNOME secrets)
      mpv                       # general-purpose media player
      nautilus                  # GTK file manager
      nerd-fonts.jetbrains-mono # monospace font with icon glyphs
      nwg-look                  # GTK theme switcher for wlroots compositors
      obsidian                  # markdown knowledge base / note-taking
      pavucontrol               # PulseAudio/PipeWire volume control GUI
      pinta                     # simple image editor
      playerctl                 # MPRIS media player controller
      plex-desktop              # Plex media player desktop app
      plexamp                   # Plex music player
      signal-desktop            # encrypted messaging client
      spotify                   # music streaming client
      starship                  # cross-shell prompt
      swaynotificationcenter    # notification center for wlroots compositors
      swayosd                   # on-screen display for volume/brightness
      vlc                       # versatile media player
      wl-clipboard              # Wayland clipboard utilities (wl-copy/wl-paste)
      xdg-terminal-exec         # XDG default terminal launcher spec
    ];
  };

}
