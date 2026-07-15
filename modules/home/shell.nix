{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Helper function that builds a `sudo nixos-rebuild <action> --flake ...` command.
  # `action` becomes "switch", "build", or "test", and the flake target is derived
  # dynamically from /etc/hostname, so this works unmodified across all your hosts
  # rather than hardcoding a hostname per machine.
  # Docs: https://nixos.org/manual/nixos/stable/#sec-changing-config
  # Flakes reference: https://nixos.wiki/wiki/Flakes
  mkRebuild =
    action: "sudo nixos-rebuild ${action} --flake $HOME/Projects/my-nixos#$(cat /etc/hostname)";
in
{

  # Home Manager module for configuring Zsh declaratively.
  # Options reference: https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enable
  programs.zsh = {
    enable = true;

    # Shell code injected into interactive (non-login) shell startup, i.e. ~/.zshrc.
    # Equivalent to home-manager's `initContent` (24.11+) — sets $EDITOR and sources
    # an external, non-Nix-managed rc file for things you iterate on outside the flake.
    initContent = ''
      export EDITOR=nvim
      source "$HOME/.local/share/my/shell/zsh.rc.sh"
    '';

    # Declarative shell aliases -> written into zsh's config by home-manager.
    # Options reference: https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.shellAliases
    shellAliases = {

      # Garbage-collect old Nix store generations/paths to reclaim disk space.
      # Docs: https://nixos.org/manual/nix/stable/package-management/garbage-collection.html
      nix-gc = "sudo nix-collect-garbage -d";
    }
    # Merge in rebuild aliases generated from mkRebuild via attribute-set union (//).
    # builtins.mapAttrs walks over { nix-rbs = "switch"; ... } and replaces each value
    # with the result of mkRebuild applied to it, so you don't repeat the rebuild
    # command three times by hand.
    // builtins.mapAttrs (_: mkRebuild) {
      nix-rbs = "switch"; # sudo nixos-rebuild switch  — activate the new config now
      nix-rbb = "build"; # sudo nixos-rebuild build   — build only, don't activate
      nix-rbt = "test"; # sudo nixos-rebuild test    — activate but don't persist across reboot
    };
  };

  # Same idea as above, but for Bash — kept in sync so aliases/behavior are
  # consistent regardless of which shell you drop into.
  # Options reference: https://nix-community.github.io/home-manager/options.xhtml#opt-programs.bash.enable
  programs.bash = {
    enable = true;

    # Bash's interactive shell init only sources the external rc file (no $EDITOR
    # export here — zsh is presumably the primary interactive shell).
    initExtra = ''
      export EDITOR=nvim
      source "$HOME/.local/share/my/shell/bash.rc.sh"
    '';

    shellAliases = {
      nix-gc = "sudo nix-collect-garbage -d";
    }
    // builtins.mapAttrs (_: mkRebuild) {
      nix-rbs = "switch";
      nix-rbb = "build";
      nix-rbt = "test";
    };
  };
}
