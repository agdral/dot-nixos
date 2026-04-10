{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  agenix_pack = pkgs.callPackage ./_agenix.nix {};
in {
  options.dotNixos.agenix = mkEnableOption "agenix";
  config = mkIf cfg.agenix {
    environment.systemPackages = [
      agenix_pack
      pkgs.age
    ];
  };
}
