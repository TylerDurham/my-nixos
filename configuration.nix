{
  hostname,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware/${hostname}/hardware-configuration.nix
    #./system/hyprland.nix
    ./system/packages.nix
    ./system/programs.nix
    ./modules/system/users.nix
  ];

  console = {
    font = "ter-132n";
    packages = [ pkgs.terminus_font ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

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
