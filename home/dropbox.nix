{ config, lib, pkgs, ... }:

let
  nautilusExtDir = "${pkgs.dropbox-cli.nautilusExtension}/lib/nautilus/extension-4";
in
{
  home.packages = with pkgs; [
    dropbox-cli
  ];

  # For login-shell contexts (terminals, scripts)
  home.sessionVariables.NAUTILUS_EXTENSION_DIR = nautilusExtDir;

  # For D-Bus-activated processes (Nautilus launched from desktop/Hyprland keybind)
  systemd.user.sessionVariables.NAUTILUS_EXTENSION_DIR = nautilusExtDir;

  systemd.user.sessionVariables.DISPLAY = ":0";

  systemd.user.services.dropbox = {
        Unit = {
            Description = "Dropbox service";
        };
        Install = {
            WantedBy = [ "default.target" ];
        };
        Service = {
            ExecStart = "${pkgs.dropbox}/bin/dropbox";
            Restart = "on-failure";
        };
    };
}

