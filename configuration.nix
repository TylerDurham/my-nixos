{
  hostname,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./nixos/audio.nix
    ./nixos/hyprland.nix
    ./nixos/packages.nix
    ./nixos/programs.nix
    ./nixos/users.nix
  ];

  console = {
    font = "ter-132n";
    packages = [ pkgs.terminus_font ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.getty.autologinUser = "dtd";

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
