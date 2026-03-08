{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  agenix = pkgs.callPackage ./_agenix.nix {};
in {
  imports = [
    inputs.agenix.nixosModules.default
  ];
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
