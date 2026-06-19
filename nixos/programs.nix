{ ... }:

{
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "dtd" ];
  };
}
