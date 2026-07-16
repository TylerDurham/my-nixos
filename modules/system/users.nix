{ pkgs, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "kvm" ]; # kvm: /dev/kvm access for Claude Cowork's microVM
    packages = with pkgs; [
      claude-code
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIF0MyXTqMTH4SoUBocralanLGXtymmBxTc5t7cwi9mI"
    ];
  };
}
