{ stdenv }:

stdenv.mkDerivation {
  name = "sf-pro-fonts";
  version = "1.0";

  src = ../../../fonts/sf-pro;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    find . -name "*.otf" -exec cp {} $out/share/fonts/opentype/ \;
    find . -name "*.ttf" -exec cp {} $out/share/fonts/opentype/ \;
  '';

  meta = {
    description = "Apple SF Pro Display fonts (manually provided)";
  };
}
