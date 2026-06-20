# modules/optional/plymouth.nix
#
# Opt-in Plymouth boot splash. Import this from your host's module list and
# flip it on per-host with:
#
#   modules.plymouth.enable = true;
#
# Rename the `modules.plymouth` namespace below if your tree uses a different
# convention (e.g. nesting under a `boot` or `system` category).
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.plymouth;

  # Curated presets. Each maps a friendly name to a theme plus an optional
  # plymouthd.conf tweak. The string values are adi1090x *directory* names
  # (lowercase, underscores), which is what both `theme` and the
  # `selected_themes` override expect.
  presets = {
    rings = {
      theme = "rings";
      extraConfig = "";
    };
    lone = {
      theme = "lone";
      extraConfig = "ShowDelay=0";
    };
    cuts = {
      theme = "cuts";
      extraConfig = "ShowDelay=0";
    };
    circuit = {
      theme = "circuit";
      extraConfig = "";
    };
    connect = {
      theme = "connect";
      extraConfig = "";
    };
  };

  selectedPreset = if cfg.preset != null then presets.${cfg.preset} else null;
in
{
  options.modules.plymouth = {
    enable = lib.mkEnableOption "Plymouth graphical boot splash";

    preset = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum (lib.attrNames presets));
      default = null;
      example = "lone";
      description = ''
        Optional curated preset. Selecting one sets `theme` (and a sensible
        `extraConfig`) for you via `mkDefault`, so explicitly setting either of
        those still wins. Leave null to drive everything manually.
        Available: ${lib.concatStringsSep ", " (lib.attrNames presets)}.
      '';
    };

    theme = lib.mkOption {
      type = lib.types.str;
      default = "rings";
      example = "lone";
      description = ''
        Plymouth theme name. Must match a theme directory provided by one of
        the packages in `themePackages`. With the default `themePackages`,
        this is the directory name of an adi1090x theme.
      '';
    };

    themePackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ cfg.theme ];
        })
      ];
      defaultText = lib.literalExpression ''
        [
          (pkgs.adi1090x-plymouth-themes.override {
            selected_themes = [ cfg.theme ];
          })
        ]
      '';
      description = ''
        Packages providing Plymouth themes. Defaults to building only the
        selected adi1090x theme, avoiding the full ~524M closure that the
        unoverridden package pulls in. Set this explicitly (and likely clear
        the default) if you use a theme from another source, e.g. the
        nixpkgs `breeze` variant.
      '';
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      example = "ShowDelay=0";
      description = ''
        Extra lines appended to plymouthd.conf (maps to
        `boot.plymouth.extraConfig`). Handy for tuning like `ShowDelay=0`.
        A value set here overrides whatever a `preset` would supply.
      '';
    };

    silentBoot = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Suppress kernel and init console output so the splash isn't fighting
        with log spew. Lowers consoleLogLevel, quiets the initrd, and adds the
        relevant kernel params. (`splash` is added automatically by the
        Plymouth module itself, so it isn't repeated here.)
      '';
    };

    useSystemdInitrd = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Use systemd in the initrd. Recommended on LUKS systems so the
        encryption password prompt is themed instead of falling back to text
        mode. This is purely an initrd concern and is independent of any
        stage-2 / home-manager systemd session settings.
      '';
    };

    hideBootloaderMenu = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Set `boot.loader.timeout = 0` to hide the bootloader menu for a
        seamless splash. The menu is still reachable by holding a key during
        boot.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # Apply preset values at mkDefault priority so explicit settings win.
    modules.plymouth = lib.mkIf (selectedPreset != null) {
      theme = lib.mkDefault selectedPreset.theme;
      extraConfig = lib.mkDefault selectedPreset.extraConfig;
    };

    boot = {
      plymouth = {
        enable = true;
        inherit (cfg) theme themePackages extraConfig;
      };

      initrd.systemd.enable = lib.mkIf cfg.useSystemdInitrd true;

      # Silent boot
      consoleLogLevel = lib.mkIf cfg.silentBoot 3;
      initrd.verbose = lib.mkIf cfg.silentBoot false;
      kernelParams = lib.mkIf cfg.silentBoot [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
      ];

      loader.timeout = lib.mkIf cfg.hideBootloaderMenu 0;
    };
  };
}
