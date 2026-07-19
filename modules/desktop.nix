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
    ./system/gaming.nix
    ./system/desktops/hyprland.nix
  ];

  options.modules.desktop = {
    enable = mkEnableOption "Desktop packages and services.";
  };

  config = mkIf cfg.enable {
    services.fprintd.enable = true;
    security.pam.services.sudo.fprintAuth = true;
    security.pam.services.polkit-1.fprintAuth = true;

    # Secret Service provider (org.freedesktop.secrets) for apps that store
    # credentials via libsecret, e.g. Claude Desktop's Electron safeStorage.
    services.gnome.gnome-keyring.enable = true;
    # Unlock the login keyring via PAM. getty autologin is the "login"
    # service; with password autologin there's no password to unlock with, so
    # the keyring prompts (via gcr) on first use instead.
    security.pam.services.login.enableGnomeKeyring = true;

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


    # Claude Cowork runs a KVM microVM that talks to the host over vsock.
    # kvm_amd/kvm_intel auto-load from CPU detection; vhost_vsock does not.
    # (qemu itself is bundled into the claude-desktop wrapper's PATH.)
    boot.kernelModules = [ "vhost_vsock" ];

    # Cowork's Linux support probe (in app.asar) gates on three tool paths it
    # resolves outside the app bundle. On anything but Ubuntu 22.x it demands
    # them at Debian/FHS absolute paths; when any is missing it reports "Cowork
    # requires QEMU"/"QEMU or its UEFI firmware is not installed" — even though
    # qemu is already on the wrapper's PATH. Symlink the two it can't otherwise
    # find into place:
    #   - OVMF firmware at /usr/share/OVMF/OVMF_{CODE,VARS}.fd. The app derives
    #     the writable VARS *template* by replacing CODE->VARS in the CODE path,
    #     so both must sit side by side under the same name stem.
    #   - virtiofsd at /usr/libexec/virtiofsd. The copy bundled in the app is
    #     only used on Ubuntu 22.x (`Dtn(e)`), so NixOS needs it on-disk here.
    systemd.tmpfiles.rules = [
      "L+ /usr/share/OVMF/OVMF_CODE.fd - - - - ${pkgs.OVMF.fd}/FV/OVMF_CODE.fd"
      "L+ /usr/share/OVMF/OVMF_VARS.fd - - - - ${pkgs.OVMF.fd}/FV/OVMF_VARS.fd"
      "L+ /usr/libexec/virtiofsd - - - - ${pkgs.virtiofsd}/bin/virtiofsd"
    ];

    environment.systemPackages = with pkgs; [
      (callPackage ./system/programs/claude-desktop.nix {}) # official Claude desktop app (beta)
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
