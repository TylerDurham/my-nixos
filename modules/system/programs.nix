{ ... }:

{
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  boot.plymouth.enable = true;
  # gnome-keyring (Secret Service) is enabled in modules/desktop.nix
  programs.nix-ld.enable = true; # Needed for stylua to be installed by Mason in Neovim
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "dtd" ];
  };
}
