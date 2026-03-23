{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.docker = mkOption {
    type = types.bool;
    default = false;
  };
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
