{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  responsively_pack = pkgs.callPackage ./_responsively.nix {};
  name = "responsively";
in {
  options.dotNixos.${name} = mkEnableOption "${name}";
  config = mkIf cfg.${name} {
    environment.systemPackages = [
      responsively_pack
    ];
  };
}
