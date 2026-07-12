{ lib, ... }:

{
  options.modules.development = {
    enable = lib.mkEnableOption "Development tools";
  };
}
