{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  agenix_pack = inputs.agenix.packages.x86_64-linux.default;
in {
  options.dotNixos.agenix = mkOption {
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.agenix {
    environment.systemPackages = [
      agenix_pack
    ];
  };
}
