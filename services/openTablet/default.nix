{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.openTablet = mkOption {
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.openTablet {
    hardware = {
      opentabletdriver = {
        enable = true;
        package = pkgs.opentabletdriver;
      };
    };
  };
}
