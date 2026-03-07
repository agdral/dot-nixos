{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  sonixFlaher = pkgs.callPackage ./_sonixFlasher.nix {};
in {
  options.dotNixos.sonixQmk = mkOption {
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.sonixQmk {
    services.udev.packages = [
      (pkgs.writeTextFile {
        name = "qmk-udev-rules";
        destination = "/lib/udev/rules.d/50-qmk.rules";
        text = builtins.readFile (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/SonixQMK/qmk_firmware/sn32_develop/util/udev/50-qmk.rules";
          sha256 = "1b6l8gnqar24985blfipya29zdzr0cfpxi9mdp1xdcsf71s0phxk";
        });
      })
    ];
    environment.systemPackages = [
      sonixFlaher
    ];
  };
}
