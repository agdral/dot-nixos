{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.xserver = mkOption {
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.xserver {
    services = {
      xserver = {
        xkb = {
          layout = "us";
          variant = "altgr-intl";
        };
      };
    };
  };
}
