{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    curl
    fzf
    ghostty
    hyprlauncher
    kitty
    lsd
    nautilus
    neovim
    nwg-look
    ripgrep
    rofi
    starship
    stow
    terminus_font
    tmux
    vim
    waybar
    wget
    wl-clipboard
  ];
}
