{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  agenix = pkgs.callPackage ./_agenix.nix {};
in {
  options.dotNixos.agenix = mkOption {
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.agenix {
    environment.systemPackages = [
      agenix
    ];
  };
}
