{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initContent = ''
      source "$HOME/.local/share/my/shell/zsh.rc.sh"
    '';
    shellAliases = {
      btw      = "echo 'I use NixOS, btw...'";
      nix-rb   = "sudo nixos-rebuild switch --flake $HOME/Projects/my-nixos#nixos";
      nix-gc   = "sudo nix-collect-garbage -d";
    };
  };
}
