{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  padloc_pack = pkgs.callPackage ./_padloc.nix {};
  name = "padloc";
in {
  options.dotNixos.${name} = mkEnableOption "${name}";
  config = mkIf cfg.${name} {
    environment.systemPackages = [
      padloc_pack
    ];
  };
}

