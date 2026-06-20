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
    ./nixos/audio.nix
    ./nixos/hyprland.nix
    ./nixos/packages.nix
    ./nixos/programs.nix
    ./nixos/plymouth.nix
    ./nixos/users.nix
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

  services.getty.autologinUser = "dtd";
  services.sshd.enable = true;

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
