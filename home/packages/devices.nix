{ pkgs, ...}:
{
  home.packages = with pkgs; [
    # Logitech drivers
    logiops
  ];
}
