{ config, pkgs, ... }:

{
  services.openssh.enable = true;

  # Security settings
  services.openssh.settings = {
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
    PermitRootLogin = "prohibit-password";
  };
}
