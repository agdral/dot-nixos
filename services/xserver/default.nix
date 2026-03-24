{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.xserver = mkEnableOption "xserver";
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
