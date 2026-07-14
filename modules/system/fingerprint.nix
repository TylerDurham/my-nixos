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
  };
}
