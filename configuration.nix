{
  hostname,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hosts/${hostname}/hardware-configuration.nix
    #./system/hyprland.nix
    ./system/packages.nix
    ./system/programs.nix
    ./system/plymouth.nix
    ./system/services/sshd.nix
    ./system/users.nix
  ];

  console = {
    font = "ter-132n";
    packages = [ pkgs.terminus_font ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;


  # networking.firewall = {
  #   allowedTCPPorts = [ 17500 ];  # Dropbox LAN sync (optional)
  #   allowedUDPPorts = [ 17500 ];  # Dropbox LAN sync (optional)
  # };

  # systemd.user.services.dropbox = {
  #   description = "Dropbox";
  #   after = [ "xembedsniproxy.service" ];
  #   wants = [ "xembedsniproxy.service" ];
  #   wantedBy = [ "graphical-session.target" ];
  #   environment = {
  #     QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
  #     QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
  #   };
  #   serviceConfig = {
  #     ExecStart = "${pkgs.dropbox.out}/bin/dropbox";
  #     ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
  #     KillMode = "control-group"; # upstream recommends process
  #     Restart = "on-failure";
  #     PrivateTmp = true;
  #     ProtectSystem = "full";
  #     Nice = 10;
  #   };
  # };

  modules.plymouth = {
    enable = true;
    preset = "lone";   # -> theme = "lone", extraConfig = "ShowDelay=0"
  };

  # Filesystek/networking
  services.gvfs.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  services.getty.autologinUser = "dtd";
  services.power-profiles-daemon.enable = true;
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "26.05";
}
