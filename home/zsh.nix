{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initContent = ''
      source "$HOME/.local/share/my/shell/zsh.rc.sh"
    '';
    shellAliases = {
      nix-rb = "sudo nixos-rebuild switch --flake $HOME/Projects/my-nixos#nixos";
      nix-gc = "sudo nix-collect-garbage -d";
    };
  };
}
