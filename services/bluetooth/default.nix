{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  name = "bluetooth";
in {
  options.dotNixos.${name} = mkEnableOption "${name}";
  config = mkIf cfg.${name} {
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
