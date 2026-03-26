{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.docker = mkEnableOption "docker";
  config = mkIf cfg.docker {
    virtualisation = {
      docker = {
        enable = true;
        daemon.settings = {
          ipv6 = false;
        };
      };
    };
  };
}
