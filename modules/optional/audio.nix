{ config, lib, ... }:

with lib;

let
  cfg = config.modules.audio;
in
{
  options.modules.audio = {
    enable = mkEnableOption "PipeWire audio stack with PulseAudio compatibility";
  };

  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
