# TODO: Need to add this to modules
{ pkgs, ... }:
let
  graphite = pkgs.graphite-gtk-theme.override {
    themeVariants = [ "orange" ];       # default|purple|pink|red|orange|yellow|green|teal|blue|all (default: grey)
    colorVariants = [ "dark" ];          # standard|light|dark
    sizeVariants  = [ "standard" ];      # standard|compact
    tweaks        = [ "rimless" "black" "normal" ];       # nord|black|darker|rimless|normal|colorful
  };
in
{
  gtk = {
    enable = true;
    theme = {
      name = "Graphite-orange-Dark";       # must match the built dir name — see note below
      package = graphite;
    };
    iconTheme = {                          # add this block
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
    };
  };

  home.file = {
    ".config/gtk-4.0/gtk.css".source =
      "${graphite}/share/themes/Graphite-Dark/gtk-4.0/gtk.css";
    ".config/gtk-4.0/gtk-dark.css".source =
      "${graphite}/share/themes/Graphite-Dark/gtk-4.0/gtk-dark.css";
    ".config/gtk-4.0/assets".source =
      "${graphite}/share/themes/Graphite-Dark/gtk-4.0/assets";
  };
}

