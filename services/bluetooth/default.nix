{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.bluetooth = mkEnableOption "bluetooth";
  config = mkIf cfg.bluetooth {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
        input = {
          General = {
            UserspaceHID = true;
            ClassicBondedOnly = false;
          };
        };
      };
    };
    services = {
      blueman.enable = true;
    };
  };
}
