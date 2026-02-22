{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.bluetooth = mkOption {
    type = types.bool;
    default = false;
  };
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
