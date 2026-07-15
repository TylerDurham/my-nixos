{ stdenv }:

stdenv.mkDerivation {
  name = "special-elite-font";
  version = "1.0";

  src = ../../../fonts/special-elite;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    find . -name "*.otf" -exec cp {} $out/share/fonts/opentype/ \;
    find . -name "*.ttf" -exec cp {} $out/share/fonts/opentype/ \;
  '';

  meta = {
    description = "A little bit of inked up grunge and a little old school analog flavor work together to give you a vintage typewriter typeface for your website and designs. (manually provided)";
  };
}
