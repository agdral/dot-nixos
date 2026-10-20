{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  sonixFlaher = pkgs.callPackage ./_sonixFlasher.nix {};
  name = "sonixQmk";
in {
  options.dotNixos.${name} = mkEnableOption "${name}";
  config = mkIf cfg.${name} {
    services.udev.packages = [
      (pkgs.writeTextFile {
        name = "qmk-udev-rules";
        destination = "/lib/udev/rules.d/50-qmk.rules";
        text = builtins.readFile (pkgs.fetchurl {
          url = "https://github.com/SonixQMK/qmk_udev/releases/download/v0.1.24/50-qmk.rules";
          sha256 = "0jmm8vm6rb4y1ans9d3v88zcyg1jn2rqa8fyb4ydnb2ngbv9nrb1";
        });
      })
    ];
    environment.systemPackages = [
      sonixFlaher
    ];
  };
}
