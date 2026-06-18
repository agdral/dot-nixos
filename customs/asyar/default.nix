{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  asyar_pack = pkgs.callPackage ./_asyar.nix {};
  name = "asyar";
in {
  options.dotNixos.${name} = mkEnableOption "${name}";
  config = mkIf cfg.${name} {
    environment.systemPackages = [
      asyar_pack
    ];
  };
}

