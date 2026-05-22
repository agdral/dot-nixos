{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  responsively_pack = pkgs.callPackage ./_responsively.nix {};
in {
  options.dotNixos.responsively = mkEnableOption "responsively";
  config = mkIf cfg.responsively {
    environment.systemPackages = [
      responsively_pack
    ];
  };
}
