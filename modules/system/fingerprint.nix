{ config, lib, ... }:

with lib;

let
  cfg = config.modules.fingerprint;
in
{
  options.modules.fingerprint = {
    enable = mkEnableOption "Fingerprint authentication via fprintd.";
  };

  config = mkIf cfg.enable {
    services.fprintd.enable = true;

    security.pam.services.hyprlock.fprintAuth = true;
    security.pam.services."1password".fprintAuth = true;

    # The Goodix reader (27c6:609c) autosuspends after 2s idle and often fails
    # to reinitialize on wake, so fingerprint auth silently stops working after
    # the machine has been idle for a while. Disable USB autosuspend for it.
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="27c6", ATTR{idProduct}=="609c", TEST=="power/control", ATTR{power/control}="on"
    '';
  };
}
