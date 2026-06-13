{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  agenix_pack = pkgs.callPackage ./_agenix.nix {};
  name = "agenix";
in {
  options.dotNixos.${name} = mkEnableOption "${name}";
  config = mkIf cfg.${name} {
    environment.systemPackages = [
      agenix_pack
      pkgs.age
    ];
  };
}
