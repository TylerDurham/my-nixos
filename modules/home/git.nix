# TODO: Need to add this to modules

{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Tyler Durham";
      user.email = "TylerDurham@noreply.users.github.com";

      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
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
