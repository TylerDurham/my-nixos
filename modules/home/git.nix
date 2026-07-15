# TODO: Need to add this to modules

{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Tyler Durham";
      user.email = "TylerDurham@noreply.users.github.com";
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIF0MyXTqMTH4SoUBocralanLGXtymmBxTc5t7cwi9mI";

      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";

      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/run/current-system/sw/bin/op-ssh-sign";
      commit.gpgsign = true;
    };

  };

  home.packages = with pkgs; [
    lazygit
  ];

  # optional niceties
  programs.delta = {
    enable = true;        # nicer diffs
    enableGitIntegration = true;
    # ignores = [ "*.swp" ".direnv" "result" ];
  };
}
