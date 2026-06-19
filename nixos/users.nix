{ pkgs, ... }:

{
  users.users.dtd = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      claude-code
      tree
    ];
  };
}
