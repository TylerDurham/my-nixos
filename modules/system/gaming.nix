{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.gaming;
in
{
  options.modules.gaming = {
    enable = mkEnableOption "Steam and gaming support (AMD/Wayland)";
  };

  config = mkIf cfg.enable {
    # Steam ships its own Proton, so Windows games work once the FHS wrapper
    # and 32-bit graphics stack are in place. On AMD the default Mesa RADV
    # Vulkan driver handles everything — no proprietary driver needed.
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;      # Steam Remote Play / in-home streaming
      dedicatedServer.openFirewall = false; # flip on if you host game servers
      gamescopeSession.enable = true;       # "Gaming Mode" session via gamescope
    };

    # gamescope: micro-compositor that gives proper fullscreen, resolution
    # scaling and framerate limiting without fighting Hyprland's Wayland
    # compositor. Launch a game with `gamescope -f -- %command%`.
    programs.gamescope.enable = true;

    # gamemode: applies CPU governor / process priority tweaks while a game is
    # running. Add `gamemoderun %command%` to a title's launch options.
    programs.gamemode.enable = true;

    # 32-bit graphics libraries are required for most games and Proton.
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      mangohud   # in-game FPS/frametime/temp overlay (`mangohud %command%`)
      protonup-qt # manage Proton-GE builds (fixes games stock Proton chokes on)
      # heroic    # GOG / Epic / Amazon launcher
      # lutris    # multi-platform game launcher (also non-Steam stores)
    ];
  };
}
