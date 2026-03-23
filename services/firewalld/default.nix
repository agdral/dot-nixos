{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.firewalld = mkOption {
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.firewalld {
    services.firewalld.enable = true;
  };
}
