{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  agenax_pack = pkgs.callPackage ./_agenax.nix {};
  name = "agenax";
in {
  options.dotNixos.${name} = mkEnableOption "${name}";
  config = mkIf cfg.${name} {
    environment.systemPackages = [
      agenax_pack
      pkgs.age
    ];
  };
}
