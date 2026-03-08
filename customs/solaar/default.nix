{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.solaar = mkOption {
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.solaar {
    services = {
      solaar = {
        enable = true;
        window = "hide";
      };
    };
  };
}
