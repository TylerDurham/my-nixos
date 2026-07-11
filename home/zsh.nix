# TODO: Need to add this to modules
{ config, lib, pkgs, ... }:
let
  mkRebuild = action:
    "sudo nixos-rebuild ${action} --flake $HOME/Projects/my-nixos#$(cat /etc/hostname)";
in
{
  programs.zsh = {
    enable = true;
    initContent = ''
      export EDITOR=nvim
      source "$HOME/.local/share/my/shell/zsh.rc.sh"
    '';
    shellAliases = {
      btw    = "echo 'I use NixOS, btw...'";
      nix-gc = "sudo nix-collect-garbage -d";
    } // builtins.mapAttrs (_: mkRebuild) {
      nix-rbs = "switch";
      nix-rbb = "build";
      nix-rbt = "test";
    };
  };
}
