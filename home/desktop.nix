{ config, lib, pkgs, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;   # actually mkdir the folders
    desktop     = "${config.home.homeDirectory}/Desktop";
    documents   = "${config.home.homeDirectory}/Documents";
    download    = "${config.home.homeDirectory}/Downloads";
    music       = "${config.home.homeDirectory}/Music";
    pictures    = "${config.home.homeDirectory}/Pictures";
    videos      = "${config.home.homeDirectory}/Videos";
    templates   = "${config.home.homeDirectory}/Templates";
    publicShare = "${config.home.homeDirectory}/Public";
  };

  xdg.desktopEntries = {
    "nwg-look" = {
      name = "GTK Settings (nwg-look)";
      genericName = "Adjust Look and Feel";
      exec = "nwg-look";
      icon = "nwg-look";
      categories = [ "Settings" ];
    };
    "org.gnome.Nautilus" = {
      name = "Files (Nautilus)";
      exec = "nautilus --new-window %U";
      icon = "org.gnome.Nautilus";
      categories = [ "GNOME" "GTK" "Utility" "FileManager" ];
      mimeType = [ "inode/directory" ];
    };
  };
}
