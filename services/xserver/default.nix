{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  name = "xserver";
in {
  options.dotNixos.${name} = mkEnableOption "${name}";
  config = mkIf cfg.${name} {
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
