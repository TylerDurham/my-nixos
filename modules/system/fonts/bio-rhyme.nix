{ stdenv }:

stdenv.mkDerivation {
  name = "biorhyme-fonts";
  version = "1.0";

  src = ../../../fonts/bio-rhyme;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    find . -name "*.otf" -exec cp {} $out/share/fonts/opentype/ \;
    find . -name "*.ttf" -exec cp {} $out/share/fonts/opentype/ \;
  '';

  meta = {
    description = "BiRhyme fonts (manually provided)";
  };
}
