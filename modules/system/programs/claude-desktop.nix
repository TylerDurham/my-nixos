{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  wrapGAppsHook3,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  cairo,
  cups,
  dbus,
  expat,
  glib,
  gtk3,
  libcap_ng,
  libdrm,
  libGL,
  libglvnd,
  libgbm,
  libnotify,
  libseccomp,
  libsecret,
  libuuid,
  libxkbcommon,
  mesa,
  nspr,
  nss,
  pango,
  qemu_kvm,
  systemd,
  vulkan-loader,
  wayland,
  xdg-utils,
  xorg,
}:

# Anthropic's official Claude Desktop for Linux (beta), repackaged from the
# .deb published in their apt repo at https://downloads.claude.ai. The .deb is
# a self-contained Electron/Chromium bundle, so we just extract it, patch the
# ELF binaries for the Nix store, and wrap the launcher with the GTK/GPU env.
#
# To update: bump `version`, then run
#   nix store prefetch-file --json \
#     "https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/claude-desktop_<version>_amd64.deb"
# and paste the resulting `hash` below.
stdenv.mkDerivation (finalAttrs: {
  pname = "claude-desktop";
  version = "1.22209.0";

  src = fetchurl {
    url = "https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/claude-desktop_${finalAttrs.version}_amd64.deb";
    hash = "sha256-bRiueSwr3a0B7cl8LD9M9IkATO/o/tZ2Cmlu0lxJv2E=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
    wrapGAppsHook3
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libcap_ng
    libdrm
    libgbm
    libnotify
    libseccomp
    libsecret
    libuuid
    libxkbcommon
    mesa
    nspr
    nss
    pango
    systemd # libudev.so.1
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXtst
    xorg.libxcb
  ];

  # We do the gApps wrapping by hand so we can merge it into the single
  # makeWrapper call for the launcher below.
  dontWrapGApps = true;

  # Stream the data tarball out rather than `dpkg-deb -x`: the .deb marks
  # chrome-sandbox setuid, which tar can't apply in the build sandbox. We drop
  # that file below anyway, so ignore permission/owner bits on extraction.
  unpackPhase = ''
    runHook preUnpack
    dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib
    cp -r usr/lib/claude-desktop $out/lib/claude-desktop
    cp -r usr/share $out/share

    # Chromium's setuid sandbox helper can't be setuid-root from the Nix
    # store. Dropping it makes Electron fall back to the unprivileged user
    # namespace sandbox, which NixOS allows by default.
    rm -f $out/lib/claude-desktop/chrome-sandbox

    makeWrapper $out/lib/claude-desktop/claude-desktop $out/bin/claude-desktop \
      "''${gappsWrapperArgs[@]}" \
      --add-flags "--password-store=basic" \
      --prefix LD_LIBRARY_PATH : "${
        lib.makeLibraryPath [
          libGL
          libglvnd
          vulkan-loader
          wayland
        ]
      }" \
      --prefix PATH : "${
        lib.makeBinPath [
          xdg-utils
          qemu_kvm # Cowork resolves qemu-system-x86_64 off PATH to boot its KVM microVM
        ]
      }"

    runHook postInstall
  '';

  meta = {
    description = "Official Claude desktop app for Linux (beta), repackaged from Anthropic's .deb";
    homepage = "https://claude.com/download";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "claude-desktop";
  };
})
