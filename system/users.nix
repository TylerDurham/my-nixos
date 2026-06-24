{ pkgs, ... }:

{
  users.users.dtd = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      claude-code
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIF0MyXTqMTH4SoUBocralanLGXtymmBxTc5t7cwi9mI"
    ];
  };
}
