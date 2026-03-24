{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.openTablet = mkEnableOption "openTablet";
  config = mkIf cfg.openTablet {
    hardware = {
      opentabletdriver = {
        enable = true;
        package = pkgs.opentabletdriver;
      };
    };
  };
}
