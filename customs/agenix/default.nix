{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
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
      inputs.agenix.packages.x86_64-linux.default
    ];
  };
}
