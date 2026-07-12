{ config, lib, pkgs, ... }:

let
  ext = pkgs.dropbox-cli.nautilusExtension;
  nautilusExtDir = "${ext}/lib/nautilus/extension-4";
in
{
  home.packages = with pkgs; [
    dropbox-cli
  ];

  # Nautilus 43+ reads NAUTILUS_4_EXTENSION_DIR (not NAUTILUS_EXTENSION_DIR)
  home.sessionVariables.NAUTILUS_4_EXTENSION_DIR = nautilusExtDir;
  systemd.user.sessionVariables.NAUTILUS_4_EXTENSION_DIR = nautilusExtDir;

  systemd.user.sessionVariables.DISPLAY = ":0";

  # Place emblems in the hicolor icon theme so Nautilus can render sync badges
  xdg.dataFile = {
    "icons/hicolor/64x64/emblems/emblem-dropbox-uptodate.png".source =
      "${ext}/share/nautilus-dropbox/emblems/emblem-dropbox-uptodate.png";
    "icons/hicolor/64x64/emblems/emblem-dropbox-syncing.png".source =
      "${ext}/share/nautilus-dropbox/emblems/emblem-dropbox-syncing.png";
    "icons/hicolor/64x64/emblems/emblem-dropbox-unsyncable.png".source =
      "${ext}/share/nautilus-dropbox/emblems/emblem-dropbox-unsyncable.png";
  };

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
      # Override Dropbox's bundled Firefox by pointing BROWSER at xdg-open.
      # Use the full store path — the bwrap sandbox has its own /usr but mounts /nix.
      Environment = [ "BROWSER=${pkgs.xdg-utils}/bin/xdg-open" ];
    };
  };
}
